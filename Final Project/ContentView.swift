//
//  ContentView.swift
//  Final Project
//
//  Created by Zach Biggs on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    @State var allSongs: [Song] = []
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($allSongs, id: \.Id, content: {song in
                        NavigationLink(destination: EditView(id: song.Id.wrappedValue, title: song.Title.wrappedValue, artist: song.Artist.wrappedValue, album: song.Album.wrappedValue, genre: song.Genre.wrappedValue, year: song.Year.wrappedValue)) { SongTile(song: song)
                        }
                    }).onDelete(perform: {indexSet in
                        //gets the deleted song, removes it from the list, deletes from db via API
                        if let index = indexSet.first {
                            let toRemove = allSongs[index]
                            allSongs.remove(atOffsets: indexSet)
                            delete(song: toRemove, completion: {
                                error in
                                if let error = error {
                                    print("error: \(error)")
                                }
                            })
                        }
                        populateList()
                    })
                }
                Button("Fetch Data") {
                    populateList()
                }.navigationTitle("Songs")
                    .toolbar(content: { NavigationLink("Add", destination: AddView(title: "", artist: "", album: "", genre: "", year: ""))
                        
                })
            }
        }
    }
    // retrieves all the songs from the api and put into list for the list view
    func populateList() {
        allSongs = []
        getAllSongs(completion: {
            songs, error in
            if let error = error {
                print("Error: \(error)")
            } else if let songs = songs {
                for song in songs {
                    allSongs.append(song)
                }
            }
        })
    }
}


struct SongTile: View {
    @Binding var song: Song
    var body: some View {
        VStack {
            Text(song.Title)
            Text(song.Artist)
        }
    }
}

struct SongDetails: View {
    @Binding var song: Song
    var body: some View {
        VStack {
            Text("Title: \(song.Title)")
            Text("Artist: \(song.Artist)")
            Text("Album: \(song.Album)")
            Text("Genre: \(song.Genre)")
            Text("Year: \(song.Year)")
        }.padding()
    }
}

struct AddView: View {
    @State var title: String
    @State var artist: String
    @State var album: String
    @State var genre: String
    @State var year: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
            TextField("Artist", text: $artist)
            TextField("Album", text: $album)
            TextField("Genre", text: $genre)
            TextField("Year", text: $year)
            Button("Save") {
                let song = Song(Id: 0, Title: title, Artist: artist, Album: album, Genre: genre, Year: year)
                add(song: song) { error in
                    if let error = error {
                        print("error: \(error)")
                    }
                }
                dismiss()
            }
        }.padding()
    }
}

struct EditView: View {
    @State var id: Int
    @State var title: String
    @State var artist: String
    @State var album: String
    @State var genre: String
    @State var year: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
            TextField("Artist", text: $artist)
            TextField("Album", text: $album)
            TextField("Genre", text: $genre)
            TextField("Year", text: $year)
            Button("Save") {
                let song = Song(Id: id, Title: title, Artist: artist, Album: album, Genre: genre, Year: year)
                update(song: song) { error in
                    if let error = error {
                        print("error: \(error)")
                    }
                }
                dismiss()
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
