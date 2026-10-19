#Eintrag für Uebersicht
uebersicht_text_de <- paste0("<b>",vorlagen$text[i],"</b><br>",
                             "Es sind noch keine Gemeinden ausgezählt.")

uebersicht_text_fr <- paste0("<b>",vorlagen_fr$text[i],"</b><br>",
                             "Aucun résultat n'est encore connu.")

uebersicht_text_it <- paste0("<b>",vorlagen_it$text[i],"</b><br>",
                             "Nessun risultato è ancora noto.")
Ja_Anteil <- 50
Nein_Anteil <- 50

if (nrow(results_notavailable) == 0) {
print(paste0("Alle Gemeinden der Vorlage ",vorlagen$text[i]," ausgezählt!"))
    
Ja_Anteil <- round2(results_national$jaStimmenInProzent,1)
Nein_Anteil <- round2(100-results_national$jaStimmenInProzent,1)   
  

uebersicht_text_de <- paste0("<b>",vorlagen$text[i],": ",ifelse(Ja_Anteil > Nein_Anteil,"✅Ja","❌Nein"),"</b><br>",
                             "Stände: ",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2)," Ja, ",
                             results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), " Nein")
uebersicht_text_de <- gsub("NA","0",uebersicht_text_de)

uebersicht_text_fr <- paste0("<b>",vorlagen_fr$text[i],": ",ifelse(Ja_Anteil > Nein_Anteil,"✅oui","❌non"),"</b><br>",
                             "Cantons: ",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2)," oui, ",
                             results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), " non")
uebersicht_text_fr <- gsub("NA","0",uebersicht_text_fr) 

uebersicht_text_it <- paste0("<b>",vorlagen_it$text[i],": ",ifelse(Ja_Anteil > Nein_Anteil,"✅sì","❌no"),"</b><br>",
                             "Cantoni: ",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2)," sì, ",
                             results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), " no")
uebersicht_text_it <- gsub("NA","0",uebersicht_text_it) 

if (vorlagen$type[i] == "casting_vote") {
  uebersicht_text_de <- paste0("<b>",vorlagen$text[i],": ",ifelse(Ja_Anteil > Nein_Anteil,"Initiative","Gegenvorschlag"),"</b><br>")
  uebersicht_text_de <- gsub("NA","0",uebersicht_text_de)
  
  uebersicht_text_fr <- paste0("<b>",vorlagen_fr$text[i],": ",ifelse(Ja_Anteil > Nein_Anteil,"Initiative","Contre-projet"),"</b><br>")
  uebersicht_text_fr <- gsub("NA","0",uebersicht_text_fr) 
  
  uebersicht_text_it <- paste0("<b>",vorlagen_it$text[i],": ",ifelse(Ja_Anteil > Nein_Anteil,"Iniziativa","Controproposta"),"</b><br>")
  uebersicht_text_it <- gsub("NA","0",uebersicht_text_it)   
  
}  

 
} else if (sum(results$Gebiet_Ausgezaehlt) > 0 ) {  

uebersicht_text_de <- paste0("<b>",vorlagen$text[i],"</b><br>",
                          sum(results$Gebiet_Ausgezaehlt)," von ",nrow(results)," Gemeinden ausgezählt (",
                          round2((sum(results$Gebiet_Ausgezaehlt)*100)/nrow(results),1),
                          "%)<br>",
                          "Stände: ",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2)," Ja, ",
                          results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), " Nein")
uebersicht_text_de <- gsub("NA","0",uebersicht_text_de)                    

uebersicht_text_fr <- paste0("<b>",vorlagen_fr$text[i],"</b><br>Les résultats de ",
                             sum(results$Gebiet_Ausgezaehlt)," des ",nrow(results)," communes sont connus (",
                             round2((sum(results$Gebiet_Ausgezaehlt)*100)/nrow(results),1),
                             "%)<br>",
                             "Cantons: ",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2)," oui, ",
                             results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), " non")
uebersicht_text_fr <- gsub("NA","0",uebersicht_text_fr) 

uebersicht_text_it <- paste0("<b>",vorlagen_it$text[i],"</b><br>",
                             sum(results$Gebiet_Ausgezaehlt)," dei ",nrow(results)," comuni sono noti (",
                             round2((sum(results$Gebiet_Ausgezaehlt)*100)/nrow(results),1),
                             "%)<br>",
                             "Cantoni: ",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2)," sì, ",
                             results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), " no")
uebersicht_text_it <- gsub("NA","0",uebersicht_text_it) 


if (vorlagen$type[i] == "casting_vote") {
  uebersicht_text_de <- paste0("<b>",vorlagen$text[i],"</b><br>",
                               sum(results$Gebiet_Ausgezaehlt)," von ",nrow(results)," Gemeinden ausgezählt (",
                               round2((sum(results$Gebiet_Ausgezaehlt)*100)/nrow(results),1),
                               "%)<br>")
  uebersicht_text_de <- gsub("NA","0",uebersicht_text_de)                    
  
  uebersicht_text_fr <- paste0("<b>",vorlagen_fr$text[i],"</b><br>Les résultats de ",
                               sum(results$Gebiet_Ausgezaehlt)," des ",nrow(results)," communes sont connus (",
                               round2((sum(results$Gebiet_Ausgezaehlt)*100)/nrow(results),1),
                               "%)<br>")
  uebersicht_text_fr <- gsub("NA","0",uebersicht_text_fr) 
  
  uebersicht_text_it <- paste0("<b>",vorlagen_it$text[i],"</b><br>",
                               sum(results$Gebiet_Ausgezaehlt)," dei ",nrow(results)," comuni sono noti (",
                               round2((sum(results$Gebiet_Ausgezaehlt)*100)/nrow(results),1),
                               "%)<br>")
  uebersicht_text_it <- gsub("NA","0",uebersicht_text_it)   
  
}  


Ja_Anteil <- round2(results_national$jaStimmenInProzent,1)
Nein_Anteil <- round2(100-results_national$jaStimmenInProzent,1)

}

entry_overview <- data.frame(Ja_Anteil,Nein_Anteil,uebersicht_text_de,uebersicht_text_fr,uebersicht_text_it)
colnames(entry_overview) <- c("Ja","Nein","Abstimmung_de","Abstimmung_fr","Abstimmung_it")
data_overview <- rbind(data_overview,entry_overview)
