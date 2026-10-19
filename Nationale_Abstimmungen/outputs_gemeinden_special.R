###Output generieren für Datawrapper

###OUTPUT OVERVIEW
output_dw_de_overview <- get_output_gemeinden(results,language = "de")
output_dw_fr_overview <- get_output_gemeinden(results,language = "fr")
output_dw_it_overview <- get_output_gemeinden(results,language = "it")

for (z in 1:nrow(results)) {
  
  if (grepl("Intro_HauptvorlageJa_GegenvorschlagJa_StichentscheidHauptvorlage|Intro_HauptvorlageJa_GegenvorschlagNein",results$Storyboard[z]) == TRUE) {
    output_dw_de_overview$Gemeinde_color[z] <- "Initiative Ja"
    output_dw_fr_overview$Gemeinde_color[z] <- "initiative oui"
    output_dw_it_overview$Gemeinde_color[z] <- "iniziative si"
  }  
  
  if (grepl("Intro_HauptvorlageJa_GegenvorschlagJa_StichentscheidGegenvorschlag|Intro_HauptvorlageNein_GegenvorschlagJa",results$Storyboard[z]) == TRUE) {
    output_dw_de_overview$Gemeinde_color[z] <- "Gegenvorschlag Ja"
    output_dw_fr_overview$Gemeinde_color[z] <- "contre-proposition oui"
    output_dw_it_overview$Gemeinde_color[z] <- "controproposta si"
  }  
  
  
  if (grepl("Intro_HauptvorlageNein_GegenvorschlagNein",results$Storyboard[z]) == TRUE) {
    output_dw_de_overview$Gemeinde_color[z] <- "Zweimal Nein"
    output_dw_fr_overview$Gemeinde_color[z] <- "deux fois non"
    output_dw_it_overview$Gemeinde_color[z] <- "due no"
  }  
  
  if (is.na(results$Storyboard[z]) == TRUE) {
    output_dw_de_overview$Gemeinde_color[z] <- "Noch keine Resultate"
    output_dw_fr_overview$Gemeinde_color[z] <- "aucun résultat"
    output_dw_it_overview$Gemeinde_color[z] <- "nessun risultato"
  }  
  
}  

#Output speichern
write.csv(output_dw_de_overview,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_de_overview.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(output_dw_fr_overview,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_fr_overview.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(output_dw_it_overview,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_it_overview.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")

#Output Abstimmungen pro Kanton
for (c in 1:nrow(cantons_overview)) {
    if (grepl("de",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_de_overview <- output_dw_de_overview %>%
      filter(grepl(paste0(" ",cantons_overview$area_ID[c]),Gemeinde_de) == TRUE)
    write.csv(output_kanton_dw_de_overview,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_de_overview.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
    }
    if (grepl("fr",cantons_overview$languages[c]) == TRUE) {
      output_kanton_dw_fr_overview <- output_dw_fr_overview %>%
        filter(grepl(paste0(" [(]",cantons_overview$area_ID[c],"[)]"),Gemeinde_fr) == TRUE)
    write.csv(output_kanton_dw_fr_overview,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_fr_overview.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
    }
    if (grepl("it",cantons_overview$languages[c]) == TRUE) {
      output_kanton_dw_it_overview <- output_dw_it_overview %>%
        filter(grepl(paste0(" [(]",cantons_overview$area_ID[c],"[)]"),Gemeinde_it) == TRUE)
    write.csv(output_kanton_dw_it_overview,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_it_overview.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
    }
  }  

###OUTPUT INITIATIVE
#Output Abstimmungen Gemeinde
output_dw_de <- get_output_gemeinden(results,language = "de")
output_dw_fr <- get_output_gemeinden(results,language = "fr")
output_dw_it <- get_output_gemeinden(results,language = "it")

#Output speichern
write.csv(output_dw_de,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_de_initiative.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(output_dw_fr,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_fr_initiative.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(output_dw_it,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_it_initiative.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8") 

#Output Abstimmungen pro Kanton
for (c in 1:nrow(cantons_overview)) {
  if (grepl("de",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_de <- output_dw_de %>%
      filter(grepl(paste0(" ",cantons_overview$area_ID[c]),Gemeinde_de) == TRUE)
    write.csv(output_kanton_dw_de,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_de_initiative.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  }
  if (grepl("fr",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_fr<- output_dw_fr_overview %>%
      filter(grepl(paste0(" [(]",cantons_overview$area_ID[c],"[)]"),Gemeinde_fr) == TRUE)
    write.csv(output_kanton_dw_fr,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_fr_initiative.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  }
  if (grepl("it",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_it <- output_dw_it %>%
      filter(grepl(paste0(" [(]",cantons_overview$area_ID[c],"[)]"),Gemeinde_it) == TRUE)
    write.csv(output_kanton_dw_it,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_it_initiative.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  }
}  

###OUTPUT GEGENVORSCHLAG
for (r in 1:nrow(results)) {
  
  if (is.na(results$Ja_Prozent_Gegenvorschlag[r]) == FALSE) {
    results$Gemeinde_color[r] <- results$Ja_Prozent_Gegenvorschlag[r]
    results$Ja_Stimmen_In_Prozent[r] <- results$Ja_Prozent_Gegenvorschlag[r]
    results$Nein_Stimmen_In_Prozent[r] <- results$Nein_Prozent_Gegenvorschlag[r]
  }
}

#Output Abstimmungen Gemeinde
output_dw_de_gegenvorschlag <- get_output_gemeinden(results,language = "de")
output_dw_fr_gegenvorschlag <- get_output_gemeinden(results,language = "fr")
output_dw_it_gegenvorschlag <- get_output_gemeinden(results,language = "it")

#Output speichern
write.csv(output_dw_de_gegenvorschlag,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_de_gegenvorschlag.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(output_dw_fr_gegenvorschlag,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_fr_gegenvorschlag.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(output_dw_it_gegenvorschlag,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_it_gegenvorschlag.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")


#Output Abstimmungen pro Kanton
for (c in 1:nrow(cantons_overview)) {
  if (grepl("de",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_de_gegenvorschlag <- output_dw_de_gegenvorschlag %>%
      filter(grepl(paste0(" ",cantons_overview$area_ID[c]),Gemeinde_de) == TRUE)
    write.csv(output_kanton_dw_de_gegenvorschlag,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_de_gegenvorschlag.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  }
  if (grepl("fr",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_fr_gegenvorschlag <- output_dw_fr_gegenvorschlag %>%
      filter(grepl(paste0(" [(]",cantons_overview$area_ID[c],"[)]"),Gemeinde_fr) == TRUE)
    write.csv(output_kanton_dw_fr_gegenvorschlag,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_fr_gegenvorschlag.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  }
  if (grepl("it",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_it_gegenvorschlag <- output_dw_it_gegenvorschlag %>%
      filter(grepl(paste0(" [(]",cantons_overview$area_ID[c],"[)]"),Gemeinde_it) == TRUE)
    write.csv(output_kanton_dw_it_gegenvorschlag,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_it_gegenvorschlag.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  }
}  


###OUTPUT STICHENTSCHEIDUG
for (r in 1:nrow(results)) {
  if (is.na(results$Stichentscheid_Zustimmung_Hauptvorlage[r]) == FALSE) {
    results$Gemeinde_color[r] <- results$Stichentscheid_Zustimmung_Hauptvorlage[r]
    results$Ja_Stimmen_In_Prozent[r] <- results$Stichentscheid_Zustimmung_Hauptvorlage[r]
    results$Nein_Stimmen_In_Prozent[r] <- results$Stichentscheid_Zustimmung_Gegenvorschlag[r]
  }
}
#Output Abstimmungen Gemeinde
output_dw_de_stichentscheid <- get_output_gemeinden(results,language = "de")
output_dw_fr_stichentscheid <- get_output_gemeinden(results,language = "fr")
output_dw_it_stichentscheid <- get_output_gemeinden(results,language = "it")

#Output speichern
write.csv(output_dw_de_stichentscheid,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_de_stichentscheid.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(output_dw_fr_stichentscheid,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_fr_stichentscheid.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(output_dw_it_stichentscheid,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_it_stichentscheid.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")

#Output Abstimmungen pro Kanton
for (c in 1:nrow(cantons_overview)) {
  if (grepl("de",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_de_stichentscheid <- output_dw_de_stichentscheid %>%
      filter(grepl(paste0(" ",cantons_overview$area_ID[c]),Gemeinde_de) == TRUE)
    write.csv(output_kanton_dw_de_stichentscheid,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_de_stichentscheid.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  }
  if (grepl("fr",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_fr_stichentscheid <- output_dw_fr_stichentscheid %>%
      filter(grepl(paste0(" [(]",cantons_overview$area_ID[c],"[)]"),Gemeinde_fr) == TRUE)
    write.csv(output_kanton_dw_fr_stichentscheid,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_fr_stichentscheid.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  }
  if (grepl("it",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_it_stichentscheid <- output_dw_it_stichentscheid %>%
      filter(grepl(paste0(" [(]",cantons_overview$area_ID[c],"[)]"),Gemeinde_it) == TRUE)
    write.csv(output_kanton_dw_it_stichentscheid,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_it_stichentscheid.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  }
}  

cat(paste0("\nGenerated output for Vorlage ",vorlagen_short[i],"\n"))

###
count_non_gemeinden <- output_dw_de[output_dw_de$Nein_Stimmen_In_Prozent>50,]
count_yes_gemeinden <- output_dw_de[output_dw_de$Ja_Stimmen_In_Prozent>50,]
count_tie_gemeinden <- output_dw_de[output_dw_de$Ja_Stimmen_In_Prozent == 50,]
print(paste0("Nein-Stimmen: ",nrow(count_non_gemeinden),"; Ja-Stimmen: ",nrow(count_yes_gemeinden),
             "; Unentschieden: ",nrow(count_tie_gemeinden)))  



#Datawrapper-Karten aktualisieren
undertitel_overview_de <- "Es sind noch keine Gemeinden ausgezählt."
undertitel_initiative_de <- "Es sind noch keine Gemeinden ausgezählt."
undertitel_gegenvorschlag_de <- "Es sind noch keine Gemeinden ausgezählt."
undertitel_stichentscheid_de <- "Es sind noch keine Gemeinden ausgezählt."
undertitel_overview_fr <- "Aucun résultat n'est encore connu."
undertitel_initiative_fr <- "Aucun résultat n'est encore connu."
undertitel_gegenvorschlag_fr <- "Aucun résultat n'est encore connu."
undertitel_stichentscheid_fr <- "Aucun résultat n'est encore connu."
undertitel_overview_it <- "Nessun risultato è ancora noto."
undertitel_initiative_it <- "Nessun risultato è ancora noto."
undertitel_gegenvorschlag_it <- "Nessun risultato è ancora noto.."
undertitel_stichentscheid_it <- "Nessun risultato è ancora noto."

if (nrow(results_notavailable) == 0) {
  
  undertitel_overview_de <-  paste0("Resultat Initiative: <b>",
                                    round2(results_national_special_initiative$jaStimmenInProzent,1)," %</b> Ja, <b>",
                                    round2(100-results_national_special_initiative$jaStimmenInProzent,1)," %</b> Nein<br>",
                                    "Resultat Gegenvorschlag: <b>",
                                    round2(results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> Ja, <b>",
                                    round2(100-results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> Nein<br>",
                                    "Resultat Stichentscheid: <b>",
                                    round2(results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> Initiative, <b>",
                                    round2(100-results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> Gegenvorschlag"
  )
  
  undertitel_initiative_de <- paste0("Resultat Initiative: <b>",
                                     round2(results_national_special_initiative$jaStimmenInProzent,1)," %</b> Ja, <b>",
                                     round2(100-results_national_special_initiative$jaStimmenInProzent,1)," %</b> Nein")
  undertitel_gegenvorschlag_de <- paste0("Resultat Gegenvorschlag: <b>",
                                         round2(results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> Ja, <b>",
                                         round2(100-results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> Nein")
  undertitel_stichentscheid_de<- paste0("Resultat Stichentscheid: <b>",
                                        round2(results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> Initiative, <b>",
                                        round2(100-results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> Gegenvorschlag")
  
  undertitel_overview_fr <- paste0("Résultats initiative: <b>",
                                   round2(results_national_special_initiative$jaStimmenInProzent,1)," %</b> oui, <b>",
                                   round2(100-results_national_special_initiative$jaStimmenInProzent,1)," %</b> non<br>",
                                   "Résultats contre-proposition: <b>",
                                   round2(results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> oui, <b>",
                                   round2(100-results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> non<br>",
                                   "Résultats question subsidiaire: <b>",
                                   round2(results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> initiative, <b>",
                                   round2(100-results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> contre-proposition"
  )
  
  undertitel_initiative_fr <- paste0("Résultats initiative: <b>",
                                     round2(results_national_special_initiative$jaStimmenInProzent,1)," %</b> oui, <b>",
                                     round2(100-results_national_special_initiative$jaStimmenInProzent,1)," %</b> non")
  undertitel_gegenvorschlag_fr <- paste0("Résultats contre-proposition: <b>",
                                         round2(results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> oui, <b>",
                                         round2(100-results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> non")
  undertitel_stichentscheid_fr <- paste0("Résultats question subsidiaire: <b>",
                                         round2(results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> initiative, <b>",
                                         round2(100-results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> contre-proposition")
  
  undertitel_overview_it <- paste0("Risultato iniziativa: <b>",
                                   round2(results_national_special_initiative$jaStimmenInProzent,1)," %</b> sì, <b>",
                                   round2(100-results_national_special_initiative$jaStimmenInProzent,1)," %</b> no<br>",
                                   "Risultato controproposta: <b>",
                                   round2(results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> sì, <b>",
                                   round2(100-results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> no<br>",
                                   "Risultato domanda risolutiva: <b>",
                                   round2(results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> iniziativa, <b>",
                                   round2(100-results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> controproposta"
  )
  
  undertitel_initiative_it <- paste0("Risultato iniziativa: <b>",
                                     round2(results_national_special_initiative$jaStimmenInProzent,1)," %</b> sì, <b>",
                                     round2(100-results_national_special_initiative$jaStimmenInProzent,1)," %</b> no")
  undertitel_gegenvorschlag_it <- paste0("Risultato controproposta: <b>",
                                         round2(results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> sì, <b>",
                                         round2(100-results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> no")
  undertitel_stichentscheid_it <- paste0("Risultato domanda risolutiva: <b>",
                                         round2(results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> iniziativa, <b>",
                                         round2(100-results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> controproposta")

} else if  (sum(results$Gebiet_Ausgezaehlt) > 0 ) {
  
  undertitel_overview_de <- paste0("Es sind <b>",sum(results$Gebiet_Ausgezaehlt),"</b> von <b>",nrow(results),
                                   "</b> Gemeinden ausgezählt.")  
  
  undertitel_initiative_de <- paste0("Es sind <b>",sum(results$Gebiet_Ausgezaehlt),"</b> von <b>",nrow(results),
                                     "</b> Gemeinden ausgezählt.<br>Stand Initiative: <b>",
                                     round2(results_national_special_initiative$jaStimmenInProzent,1)," %</b> Ja, <b>",
                                     round2(100-results_national_special_initiative$jaStimmenInProzent,1)," %</b> Nein")
  undertitel_gegenvorschlag_de <- paste0("Es sind <b>",sum(results$Gebiet_Ausgezaehlt),"</b> von <b>",nrow(results),
                                         "</b> Gemeinden ausgezählt.<br>Stand Gegenvorschlag: <b>",
                                         round2(results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> Ja, <b>",
                                         round2(100-results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> Nein")
  undertitel_stichentscheid_de<- paste0("Es sind <b>",sum(results$Gebiet_Ausgezaehlt),"</b> von <b>",nrow(results),
                                        "</b> Gemeinden ausgezählt.<br>Stand Stichentscheid: <b>",
                                        round2(results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> Initiative, <b>",
                                        round2(100-results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> Gegenvorschlag")
  
  undertitel_overview_fr <- paste0("Les résultats de <b>",sum(results$Gebiet_Ausgezaehlt),"</b> des <b>",nrow(results),
                                   "</b> communes sont connus.")
  
  undertitel_initiative_fr <- paste0("Les résultats de <b>",sum(results$Gebiet_Ausgezaehlt),"</b> des <b>",nrow(results),
                                     "</b> communes sont connus.<br>Etat initiative: <b>",
                                     round2(results_national_special_initiative$jaStimmenInProzent,1)," %</b> oui, <b>",
                                     round2(100-results_national_special_initiative$jaStimmenInProzent,1)," %</b> non")
  undertitel_gegenvorschlag_fr <- paste0("Les résultats de <b>",sum(results$Gebiet_Ausgezaehlt),"</b> des <b>",nrow(results),
                                         "</b> communes sont connus.<br>Etat contre-proposition: <b>",
                                         round2(results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> oui, <b>",
                                         round2(100-results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> non")
  undertitel_stichentscheid_fr <- paste0("Les résultats de <b>",sum(results$Gebiet_Ausgezaehlt),"</b> des <b>",nrow(results),
                                          "</b> communes sont connus.<br>Etat question subsidiaire: <b>",
                                          round2(results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> initiative, <b>",
                                          round2(100-results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> contre-proposition")
  
  undertitel_overview_it <- paste0("I risultati di <b>",sum(results$Gebiet_Ausgezaehlt),"</b> dei <b>",nrow(results),
                                   "</b> comuni sono noti.")
  
  undertitel_initiative_it <- paste0("I risultati di <b>",sum(results$Gebiet_Ausgezaehlt),"</b> dei <b>",nrow(results),
                                     "</b> comuni sono noti.<br>Stato iniziativa: <b>",
                                     round2(results_national_special_initiative$jaStimmenInProzent,1)," %</b> sì, <b>",
                                     round2(100-results_national_special_initiative$jaStimmenInProzent,1)," %</b> no")
  undertitel_gegenvorschlag_it <- paste0("I risultati di <b>",sum(results$Gebiet_Ausgezaehlt),"</b> dei <b>",nrow(results),
                                         "</b> comuni sono noti.<br>Stato controproposta: <b>",
                                         round2(results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> sì, <b>",
                                         round2(100-results_national_special_gegenvorschlag$jaStimmenInProzent,1)," %</b> no")
  undertitel_stichentscheid_it <- paste0("I risultati di <b>",sum(results$Gebiet_Ausgezaehlt),"</b> dei <b>",nrow(results),
                                         "</b> comuni sono noti.<br>Stato domanda risolutiva: <b>",
                                          round2(results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> iniziativa, <b>",
                                          round2(100-results_national_special_stichentscheid$jaStimmenInProzent,1)," %</b> controproposta")
}


###Karten Gemeinden
datawrapper_codes_vorlage_overview <- datawrapper_codes[datawrapper_codes$Vorlage == vorlagen_short[i] &
                                                          datawrapper_codes$Typ == "Schweizer Gemeinden Karte Übersicht",]
datawrapper_codes_vorlage_initiative <- datawrapper_codes[datawrapper_codes$Vorlage == vorlagen_short[i] &
                                                            datawrapper_codes$Typ == "Schweizer Gemeinden Karte Initiative",]
datawrapper_codes_vorlage_gegenvorschlag <- datawrapper_codes[datawrapper_codes$Vorlage == vorlagen_short[i] &
                                                                datawrapper_codes$Typ == "Schweizer Gemeinden Karte Gegenvorschlag",]
datawrapper_codes_vorlage_stichentscheid <- datawrapper_codes[datawrapper_codes$Vorlage == vorlagen_short[i] &
                                                                datawrapper_codes$Typ == "Schweizer Gemeinden Karte Stichentscheid",]


for (r in 1:nrow(datawrapper_codes_vorlage_overview)) {
  if (datawrapper_codes_vorlage_overview$Sprache[r] == "de-DE") {
    dw_edit_chart(datawrapper_codes_vorlage_overview$ID[r],
                  intro=paste0(undertitel_overview_de,'<br>
<span style="line-height:30px">
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Übersicht&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Initiative&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Gegenvorschlag</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Stichentscheid</a> &nbsp;'),
                  annotate=paste0("Letzte Aktualisierung: ",format(Sys.time(),"%d.%m.%Y %H:%M Uhr")))
    dw_publish_chart(datawrapper_codes_vorlage_overview$ID[r])
  } else if (datawrapper_codes_vorlage_overview$Sprache[r] == "fr-CH") {
    dw_edit_chart(datawrapper_codes_vorlage_overview$ID[r],
                  intro=paste0(undertitel_overview_fr,'<br>
<span style="line-height:30px">
<a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;aperçu&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;initiative&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> contre-proposition</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> question subsidiaire</a> &nbsp;'),
                  annotate=paste0("dernière mise à jour: ",format(Sys.time(),"%d.%m.%Y %Hh%M")))
    dw_publish_chart(datawrapper_codes_vorlage_overview$ID[r])
  } else {
    dw_edit_chart(datawrapper_codes_vorlage_overview$ID[r],
                  intro=paste0(undertitel_overview_it,'<br>
<span style="line-height:30px">
<a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;panoramica&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;iniziativa&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> controproposta</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> domanda risolutiva</a> &nbsp;'),
                  annotate=paste0("Ultimo aggiornamento: ",format(Sys.time(),"%d.%m.%Y %H:%M")))
    dw_publish_chart(datawrapper_codes_vorlage_overview$ID[r]) 
  }  
}

for (r in 1:nrow(datawrapper_codes_vorlage_initiative)) {
  if (datawrapper_codes_vorlage_initiative$Sprache[r] == "de-DE") {
    dw_edit_chart(datawrapper_codes_vorlage_initiative$ID[r],
                  intro=paste0(undertitel_initiative_de,'<br>
<span style="line-height:30px">
<a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Übersicht&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Initiative&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Gegenvorschlag</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Stichentscheid</a> &nbsp;'),
                  annotate=paste0("Letzte Aktualisierung: ",format(Sys.time(),"%d.%m.%Y %H:%M Uhr")))
    dw_publish_chart(datawrapper_codes_vorlage_initiative$ID[r])
  } else if (datawrapper_codes_vorlage_initiative$Sprache[r] == "fr-CH") {
    dw_edit_chart(datawrapper_codes_vorlage_initiative$ID[r],
                  intro=paste0(undertitel_initiative_fr,'<br>
<span style="line-height:30px">
<a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;aperçu&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;initiative&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> contre-proposition</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> question subsidiaire</a> &nbsp;'),
                  annotate=paste0("dernière mise à jour: ",format(Sys.time(),"%d.%m.%Y %Hh%M")))
    dw_publish_chart(datawrapper_codes_vorlage_initiative$ID[r])
  } else {
    dw_edit_chart(datawrapper_codes_vorlage_initiative$ID[r],
                  intro=paste0(undertitel_initiative_it,'<br>
<span style="line-height:30px">
<a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;panoramica&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;iniziativa&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> controproposta</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> domanda risolutiva</a> &nbsp;'),
                  annotate=paste0("Ultimo aggiornamento: ",format(Sys.time(),"%d.%m.%Y %H:%M")))
    dw_publish_chart(datawrapper_codes_vorlage_initiative$ID[r])
    
  }  
}

for (r in 1:nrow(datawrapper_codes_vorlage_gegenvorschlag)) {
  if (datawrapper_codes_vorlage_gegenvorschlag$Sprache[r] == "de-DE") {
    dw_edit_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r],
                  intro=paste0(undertitel_gegenvorschlag_de,'<br>
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Übersicht&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Initiative&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Gegenvorschlag</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Stichentscheid</a> &nbsp;'),
                  annotate=paste0("Letzte Aktualisierung: ",format(Sys.time(),"%d.%m.%Y %H:%M Uhr")))
    dw_publish_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r])
  } else if (datawrapper_codes_vorlage_gegenvorschlag$Sprache[r] == "fr-CH") {
    dw_edit_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r],
                  intro=paste0(undertitel_gegenvorschlag_fr,'<br>
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;aperçu&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;initiative&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> contre-proposition</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> question subsidiaire</a> &nbsp;'),
                  annotate=paste0("dernière mise à jour: ",format(Sys.time(),"%d.%m.%Y %Hh%M")))
    dw_publish_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r])
  } else {
    dw_edit_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r],
                  intro=paste0(undertitel_gegenvorschlag_it,'<br>
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;panoramica&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;iniziativa&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> controproposta</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> domanda risolutiva</a> &nbsp;'),
                  annotate=paste0("Ultimo aggiornamento: ",format(Sys.time(),"%d.%m.%Y %H:%M")))
    dw_publish_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r])
    
  }  
}

for (r in 1:nrow(datawrapper_codes_vorlage_stichentscheid)) {
  if (datawrapper_codes_vorlage_stichentscheid$Sprache[r] == "de-DE") {
    dw_edit_chart(datawrapper_codes_vorlage_stichentscheid$ID[r],
                  intro=paste0(undertitel_stichentscheid_de,'<br>
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Übersicht&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Initiative&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Gegenvorschlag</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Stichentscheid</a> &nbsp;'),
                  annotate=paste0("Letzte Aktualisierung: ",format(Sys.time(),"%d.%m.%Y %H:%M Uhr")))
    dw_publish_chart(datawrapper_codes_vorlage_stichentscheid$ID[r])
  } else if (datawrapper_codes_vorlage_gegenvorschlag$Sprache[r] == "fr-CH") {
    dw_edit_chart(datawrapper_codes_vorlage_stichentscheid$ID[r],
                  intro=paste0(undertitel_stichentscheid_fr,'<br>
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;aperçu&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;initiative&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> contre-proposition</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> question subsidiaire</a> &nbsp;'),
                  annotate=paste0("dernière mise à jour: ",format(Sys.time(),"%d.%m.%Y %Hh%M")))
    dw_publish_chart(datawrapper_codes_vorlage_stichentscheid$ID[r])
  } else {
    dw_edit_chart(datawrapper_codes_vorlage_stichentscheid$ID[r],
                  intro=paste0(undertitel_stichentscheid_it,'<br>
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;panoramica&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;iniziativa&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> controproposta</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> domanda risolutiva</a> &nbsp;'),
                  annotate=paste0("Ultimo aggiornamento: ",format(Sys.time(),"%d.%m.%Y %H:%M")))
    dw_publish_chart(datawrapper_codes_vorlage_stichentscheid$ID[r])
  }  
}
    
