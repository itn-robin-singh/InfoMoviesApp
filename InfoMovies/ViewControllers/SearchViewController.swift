//
//  SearchViewController.swift
//  InfoMovies
//
//  Created by Robin Singh on 05/04/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var moviesListInTable: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var moviesList: [MovieInBrief] = []
    private var moviesPosterList: [MoviesPoster] = []
    private var selectedId = ""
    private var selectedPosterImage = UIImage(named: "noImage")!
    private var selectedMovieTitle = ""
    
    private let colorForList: [UIColor] = [UIColor.gray,UIColor.lightGray]
    
    private let dataManager = BriefInfoDataManager()
    
    private let favouriteListDataManager = FavouriteListDataManager.getObject()
    
    private var error: String? = nil
    private var isFetching:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesListInTable.register(MovieTableViewCell.getNib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        moviesListInTable.register(ErrorUITableViewCell.getNib(), forCellReuseIdentifier: ErrorUITableViewCell.identifer)
        moviesListInTable.dataSource = self
        moviesListInTable.delegate = self
        dataManager.delegate = self
        moviesListInTable.separatorStyle = .none
        favouriteListDataManager.initList()
        searchField.borderStyle = .none
        title = "InfoMovies"
    }
    
    @IBAction func searchMovies(_ sender: Any) {
        print(searchField.text!)
        dataManager.reset()
        moviesList = []
        moviesPosterList = []
        if searchField.text != "" {
            error = nil
            isFetching = true
            moviesListInTable.reloadData()
            dataManager.fetchMovieListFromAPI(ofMovie: searchField.text!)
        }else{
            error = "Please enter a valid input!!"
            moviesListInTable.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.moviesListInTable.reloadData()
        }
    }
    
}

extension SearchViewController: DataManagerDelegate {
    
    func initMovieTable(_ initialMoviesList: [MovieInBrief],_ initialMoviesPoster: [MoviesPoster]){
        print(initialMoviesList.count)
        print(initialMoviesPoster.count)
        moviesList = initialMoviesList
        moviesPosterList = initialMoviesPoster
        isFetching = false
        DispatchQueue.main.async {
            self.moviesListInTable.reloadData()
        }
    }
    
    func updateMovieList(_ newMoviesList: [MovieInBrief],_ newMoviesPoster: [MoviesPoster]) {
        self.moviesList = newMoviesList
        self.moviesPosterList = newMoviesPoster
        DispatchQueue.main.async {
            self.moviesListInTable.reloadData()
        }
    }
    
    func showError(error: String) {
        self.error = error
        DispatchQueue.main.async {
            self.moviesListInTable.reloadData()
        }
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if error != nil {
            return 1
        }
        if isFetching == true {
            return 1
        }
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if error != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: ErrorUITableViewCell.identifer) as! ErrorUITableViewCell
            cell.config(error: error!)
            return cell
        }
        if isFetching == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: ErrorUITableViewCell.identifer) as! ErrorUITableViewCell
            cell.config(error: "Loading Movies..")
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
        cell.backgroundColor = colorForList[indexPath.row % 2]
        if favouriteListDataManager.isInFavouriteList(imdbId: moviesList[indexPath.row].imdbID) == false {
            cell.favroiteButton.setTitle("Add to Fav.", for: UIControl.State.normal)
        }else{
            cell.favroiteButton.setTitle("Remove", for: UIControl.State.normal)
        }
        var poster = UIImage(named: "noImage")!
        if indexPath.row < moviesPosterList.count {
            poster = moviesPosterList[indexPath.row].Poster
        }
        cell.config(title: moviesList[indexPath.row].Title,
                    yearOfRelease: moviesList[indexPath.row].Year,
                    type: moviesList[indexPath.row].Type,
                    poster: poster,
                    idOfTheCell: moviesList[indexPath.row].imdbID
                    )
        cell.favouriteMovieDelegate = self
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard dataManager.fetchingData == false else {
            return
        }
        
        if scrollView.contentOffset.y > (moviesListInTable.contentSize.height - 50 - scrollView.frame.size.height){
            dataManager.fetchMovieListFromAPI(ofMovie: searchField.text!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedId = moviesList[indexPath.row].imdbID
        selectedPosterImage = moviesPosterList[indexPath.row].Poster
        selectedMovieTitle = moviesList[indexPath.row].Title
        performSegue(withIdentifier: "briefToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? DetailViewController{
            destinationController.id = selectedId
            destinationController.posterImage = selectedPosterImage
            destinationController.movieTitle = selectedMovieTitle
            destinationController.moviesList = moviesList
            destinationController.moviesPosterList = moviesPosterList
            destinationController.comeFromFavourite = false
        } else if let destinationControllerFavourite = segue.destination as? FavouriteViewController{
            destinationControllerFavourite.reloadTable()
        }
    }
}

extension SearchViewController: MovieTableViewCellDelegateForFavourite {
    func removeMovieFromFavouriteList(imdbId: String) {
        print("search movie function called")
        favouriteListDataManager.deleteAMovie(imdbId: imdbId)
        DispatchQueue.main.async {
            self.moviesListInTable.reloadData()
        }
    }
    
    func addMovieToFavouriteList(imdbID: String,poster: UIImage,year: String, title: String) {
        favouriteListDataManager.insertAMovie(
            imdbId: imdbID,
            title: title,
            yearOfRelease: year,
            poster: poster.pngData()!
        )
        DispatchQueue.main.async {
            self.moviesListInTable.reloadData()
        }
    }
    
}
