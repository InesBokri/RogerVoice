//
//  String.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 22/11/2024.
//

import Foundation

extension String {
    func formatPhoneNumber() -> String {
        guard self.starts(with: "+33") else { return self } // Gère uniquement les numéros commençant par +33
        
        var formattedNumber = self
        formattedNumber.removeFirst(3) // Supprime le préfixe +33
        var groupedNumbers = ["+33 "] // Conserve le préfixe initial
        
        for (index, char) in formattedNumber.enumerated() {
            if index == 0 {
                groupedNumbers.append(String(char)) // Ajoute le 1er caractère
                groupedNumbers.append(" ") // ajoute un espace juste apres le 1er chiffre
                
            } else {
                if index % 2 != 0 {
                    groupedNumbers.append(" ")
                }
                groupedNumbers.append(String(char)) // Ajoute le caractère actuel
            }
        }
        return groupedNumbers.joined()
    }
    
    func formattedDate() -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: self) else { return nil }
        
        let displayFormatter = DateFormatter()
        displayFormatter.locale = Locale(identifier: "fr_FR") // Locale française
        
        // Remplace les abréviations des mois par une version sans double point
        let shortMonths = ["jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sep.", "oct.", "nov.", "déc."]
        displayFormatter.shortStandaloneMonthSymbols = shortMonths
        
        // Format de la date
        displayFormatter.dateFormat = "d MMM yyyy à HH:mm"
        
        return displayFormatter.string(from: date)
    }
}
