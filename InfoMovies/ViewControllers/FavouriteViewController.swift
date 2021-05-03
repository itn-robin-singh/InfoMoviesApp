//
//  FavouriteViewController.swift
//  InfoMovies
//
//  Created by Robin Singh on 11/04/21.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet var favouriteMoviesTableView: UITableView!
    
    private let favouriteListManager = FavouriteListDataManager.getObject()
    
    private var selectedId = ""
    private var selectedPoster = UIImage(named: "noImage")!
    private var selectedTitle = ""
    
    private let colorForList: [UIColor] = [UIColor.lightGray,UIColor.gray]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteMoviesTableView.dataSource = self
        favouriteMoviesTableView.delegate = self
        favouriteMoviesTableView.register(
            MovieTableViewCell.getNib(),
            forCellReuseIdentifier: MovieTableViewCell.identifier
        )
        favouriteMoviesTableView.separatorStyle = .none
        title = "Favourite Movies"
    }
    
    func reloadTable() {
//        DispatchQueue.main.async {
//            self.favouriteMoviesTableView.reloadData()
//        }
    }
    
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(favouriteListManager.getSize())
        return favouriteListManager.getSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
        cell.backgroundColor = colorForList[indexPath.row % 2]
        cell.config(
            title: favouriteListManager.favouriteMovieList[indexPath.row].title!,
            yearOfRelease: favouriteListManager.favouriteMovieList[indexPath.row].yearOfRelease!,
            type: favouriteListManager.favouriteMovieList[indexPath.row].imdbId!,
            poster: UIImage(data: favouriteListManager.favouriteMovieList[indexPath.row].poster!)!,
            idOfTheCell: favouriteListManager.favouriteMovieList[indexPath.row].imdbId!
        )
        cell.favroiteButton.setTitle("Remove", for: UIControl.State.normal)
        cell.typeOfMovie.isHidden = true
        cell.favouriteMovieDelegate = self
        return cell
    }
    
    
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedId = favouriteListManager.favouriteMovieList[indexPath.row].imdbId!
        selectedPoster = UIImage(data: favouriteListManager.favouriteMovieList[indexPath.row].poster!)!
        selectedTitle = favouriteListManager.favouriteMovieList[indexPath.row].title!
        performSegue(withIdentifier: "favouriteToDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! DetailViewController
        destinationViewController.id = selectedId
        destinationViewController.posterImage = selectedPoster
        destinationViewController.movieTitle = selectedTitle
        destinationViewController.comeFromFavourite = true
    }
}

extension FavouriteViewController: MovieTableViewCellDelegateForFavourite {
    func addMovieToFavouriteList(imdbID: String, poster: UIImage, year: String, title: String) {
        return
    }
    
    func removeMovieFromFavouriteList(imdbId: String) {
        favouriteListManager.deleteAMovie(imdbId: imdbId)
        DispatchQueue.main.async {
            self.favouriteMoviesTableView.reloadData()
        }
    }
    
    
}
