kantone_list <- json_data_kantone[["kantone"]]

mydb <- connectDB(db_name="sda_votes")
rs <- dbSendQuery(mydb, paste0("SELECT * FROM output_overview WHERE date = '",voting_date,"' AND voting_type = 'cantonal' AND chart_results = 'done'" ))
output_overview <- DBI::fetch(rs,n=-1)
dbDisconnectAll()
completed_cantons <- unique(output_overview$area_ID)


for (k in 1:nrow(kantone_list)) {

if (sum(grepl(kantone_list$geoLevelname[k],completed_cantons)) == 0) {
  
data_overview <- data.frame(50,50,"Abstimmung_de","Abstimmung_fr","Abstimmung_it")
colnames(data_overview) <- c("Ja","Nein","Abstimmung_de","Abstimmung_fr","Abstimmung_it")  
vorlagen_kantonal <- kantone_list$vorlagen[[k]]

check_counted <- c() 

for (i in 1:nrow(vorlagen_kantonal)) {
  
kanton_letters <- substr(kantone_list$geoLevelname[k], start = 1, stop = 2)  
check_counted[i] <- FALSE
results <- get_results_kantonal(json_data_kantone,
                                  k,
                                  i)

results <- treat_gemeinden(results)
results <- format_data_g(results)


Resultat_Kanton <- get_results_kantonal(json_data_kantone,
                                          k,
                                          i,
                                          "kantonal")

#Titel aus Metadata
titel_all <- votes_metadata %>%
  filter(area_ID == kantone_list$geoLevelname[k],
         votes_ID == vorlagen_kantonal$vorlagenId[i])

#Eintrag für Uebersicht
uebersicht_text_de <- paste0("<b>",titel_all$title_de[1],"</b><br>",
                             "Es sind noch keine Gemeinden ausgezählt.")

uebersicht_text_fr <- paste0("<b>",titel_all$title_fr[1],"</b><br>",
                             "Aucun résultat n'est encore connu.")

uebersicht_text_it <- paste0("<b>",titel_all$title_it[1],"</b><br>",
                             "Nessun risultato è ancora noto.")
Ja_Anteil <- 50
Nein_Anteil <- 50

if (is.na(Resultat_Kanton[1]) == FALSE) {
  Ja_Anteil <- round2(Resultat_Kanton[1],1)
  Nein_Anteil <- round2(Resultat_Kanton[2],1)
  
  uebersicht_text_de <- paste0("<b>",titel_all$title_de[1],"</b><br>",
                               "Die brieflichen Stimmen sind ausgezählt.")
  
  uebersicht_text_fr <- paste0("<b>",titel_all$title_fr[1],"</b><br>",
                               "Les votes par correspondance ont été dépouillés.")
  
  uebersicht_text_it <- paste0("<b>",titel_all$title_it[1],"</b><br>",
                               "I voti per corrispondenza sono stati scrutinati.")
if (sum(results$Gebiet_Ausgezaehlt) > 0 ) {  
  
  uebersicht_text_de <- paste0("<b>",titel_all$title_de[1],"</b><br>",
                               sum(results$Gebiet_Ausgezaehlt)," von ",nrow(results)," Gemeinden ausgezählt (",
                               round2((sum(results$Gebiet_Ausgezaehlt)*100)/nrow(results),1),
                               "%)")
  
  uebersicht_text_fr <- paste0("<b>",titel_all$title_fr[1],"</b><br>",
                               sum(results$Gebiet_Ausgezaehlt)," des ",nrow(results)," communes sont connus (",
                               round2((sum(results$Gebiet_Ausgezaehlt)*100)/nrow(results),1),
                               "%)")
  
  uebersicht_text_it <- paste0("<b>",titel_all$title_it[1],"</b><br>",
                               sum(results$Gebiet_Ausgezaehlt)," dei ",nrow(results)," comuni sono noti (",
                               round2((sum(results$Gebiet_Ausgezaehlt)*100)/nrow(results),1),
                               "%)")
  
  if (sum(results$Gebiet_Ausgezaehlt) == nrow(results)) {
 
    uebersicht_text_de <- paste0("<b>",titel_all$title_de[1],": ",ifelse(Ja_Anteil > Nein_Anteil,"✅Ja","❌Nein"),"</b>")
    
    uebersicht_text_fr <- paste0("<b>",titel_all$title_fr[1],": ",ifelse(Ja_Anteil > Nein_Anteil,"✅oui","❌non"),"</b>")
    
    uebersicht_text_it <- paste0("<b>",titel_all$title_it[1],": ",ifelse(Ja_Anteil > Nein_Anteil,"✅sì","❌no"),"</b>")
    
    if (is.na(titel_all$type[1]) == FALSE) {
    if (titel_all$type[1] == "casting_vote") {
      uebersicht_text_de <- paste0("<b>",titel_all$title_de[1],": ",ifelse(Ja_Anteil > Nein_Anteil,"Initiative","Gegenvorschlag"),"</b>")
      
      uebersicht_text_fr <- paste0("<b>",titel_all$title_fr[1],": ",ifelse(Ja_Anteil > Nein_Anteil,"Initiative","Contre-project"),"</b>")
      
      uebersicht_text_it <- paste0("<b>",titel_all$title_it[1],": ",ifelse(Ja_Anteil > Nein_Anteil,"Iniziativa","Controproposta"),"</b>")  
    }  
    }  
    
    
    cat(paste0("Resultate von folgender kantonalen Abstimmung aus ",kantone_list$geoLevelname[k]," sind komplett:\n",
                 titel_all$title_de[1],"\n",
                 titel_all$title_fr[1],"\n",
                 titel_all$title_it[1],"\n\n"))
    check_counted[i] <- TRUE
  }  
}

}  

entry_overview <- data.frame(Ja_Anteil,Nein_Anteil,uebersicht_text_de,uebersicht_text_fr,uebersicht_text_it)
colnames(entry_overview) <- c("Ja","Nein","Abstimmung_de","Abstimmung_fr","Abstimmung_it")
data_overview <- rbind(data_overview,entry_overview)
}
data_overview <- data_overview[-1,]

if ((kantone_list$geoLevelname[k] == "BS") & (voting_date == "2025-05-18")) {
data_overview <- data_overview[c(1,3,4,2),]
}  

write.csv(data_overview,paste0("Output_Overviews/Uebersicht_dw_",kantone_list$geoLevelname[k],".csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")

#Update Datawrapper-Chart
datawrapper_ids <- datawrapper_codes %>%
  filter(Typ == "Uebersicht Kanton",
         Vorlage == kantone_list$geoLevelname[k])

for (d in 1:nrow(datawrapper_ids)) {
dw_data_to_chart(data_overview,datawrapper_ids$ID[d])

if (datawrapper_ids$Sprache[d] == "de-DE") {
if (sum(results$Gebiet_Ausgezaehlt) == nrow(results)) {  
dw_edit_chart(datawrapper_ids$ID[d],intro="")   
  } else {
dw_edit_chart(datawrapper_ids$ID[d],intro=paste0("Letzte Aktualisierung: ",format(Sys.time(),"%H:%M Uhr")))    
}    
}
if (datawrapper_ids$Sprache[d] == "fr-CH") {
  if (sum(results$Gebiet_Ausgezaehlt) == nrow(results)) {  
    dw_edit_chart(datawrapper_ids$ID[d],intro="")   
  } else {
dw_edit_chart(datawrapper_ids$ID[d],intro=paste0("Dernière mise à jour: ",format(Sys.time(),"%Hh%M")))
  }  
}
if (datawrapper_ids$Sprache[d] == "it-CH") {
  if (sum(results$Gebiet_Ausgezaehlt) == nrow(results)) {  
    dw_edit_chart(datawrapper_ids$ID[d],intro="")   
  } else {
dw_edit_chart(datawrapper_ids$ID[d],intro=paste0("Ultimo aggiornamento: ",format(Sys.time(),"%H:%M")))
  }  
}    
dw_publish_chart(datawrapper_ids$ID[d])
}

if (sum(check_counted) == nrow(vorlagen_kantonal)) {
cat(paste0("Alle Abstimmungen aus dem Kanton ",kantone_list$geoLevelname[k]," sind ausgezählt!\n\n")) 

if (simulation == FALSE) {
#Set chart output to done
mydb <- connectDB(db_name = "sda_votes")  
sql_qry <- paste0("UPDATE output_overview SET chart_results = 'done' WHERE date = '",voting_date,"' AND voting_type = 'cantonal' AND area_ID = '",kantone_list$geoLevelname[k],"'")
rs <- dbSendQuery(mydb, sql_qry)
dbDisconnectAll() 

}

}
}  else {
  cat(paste0("\nKanton ",kantone_list$geoLevelname[k]," bereits komplett\n"))  
}  
}  

