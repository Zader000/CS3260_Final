//
//  Song.swift
//  Final Project
//
//  Created by Zach Biggs on 6/27/23.
//

import Foundation

class Song: Codable, ObservableObject {
    var Id: Int;
    var Title: String;
    var Artist: String;
    var Album: String;
    var Genre: String;
    var Year: String;
    
    init(Id: Int, Title: String, Artist: String, Album: String, Genre: String, Year: String) {
        self.Id = Id
        self.Title = Title
        self.Artist = Artist
        self.Album = Album
        self.Genre = Genre
        self.Year = Year
    }
}
