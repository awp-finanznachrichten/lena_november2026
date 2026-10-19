###Output generieren für Datawrapper
  
  #Output Abstimmungen Gemeinde
  output_dw_de <- get_output_gemeinden(results,language = "de")
  output_dw_fr <- get_output_gemeinden(results,language = "fr")
  output_dw_it <- get_output_gemeinden(results,language = "it")
  
  #Output speichern
  write.csv(output_dw_de,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_de.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  write.csv(output_dw_fr,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_fr.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  write.csv(output_dw_it,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_it.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")

  #Output Abstimmungen pro Kanton
  for (c in 1:nrow(cantons_overview)) {
    if (grepl("de",cantons_overview$languages[c]) == TRUE) {
    output_kanton_dw_de <- output_dw_de %>%
      filter(grepl(paste0(" ",cantons_overview$area_ID[c]),Gemeinde_de) == TRUE)
    write.csv(output_kanton_dw_de,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_de.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
    }
    if (grepl("fr",cantons_overview$languages[c]) == TRUE) {
      output_kanton_dw_fr <- output_dw_fr %>%
        filter(grepl(paste0(" [(]",cantons_overview$area_ID[c],"[)]"),Gemeinde_fr) == TRUE)
    write.csv(output_kanton_dw_fr,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_fr.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
    }
    if (grepl("it",cantons_overview$languages[c]) == TRUE) {
      output_kanton_dw_it <- output_dw_it %>%
        filter(grepl(paste0(" [(]",cantons_overview$area_ID[c],"[)]"),Gemeinde_it) == TRUE)
    write.csv(output_kanton_dw_it,paste0("Output_Cantons/",cantons_overview$area_ID[c],"_",vorlagen_short[i],"_dw_it.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
    }
  }  

  count_non_gemeinden <- output_dw_de[output_dw_de$Nein_Stimmen_In_Prozent>50,]
  count_yes_gemeinden <- output_dw_de[output_dw_de$Ja_Stimmen_In_Prozent>50,]
  count_tie_gemeinden <- output_dw_de[output_dw_de$Ja_Stimmen_In_Prozent == 50,]
  
  print(paste0("Nein-Stimmen: ",nrow(count_non_gemeinden),"; Ja-Stimmen: ",nrow(count_yes_gemeinden),
               "; Unentschieden: ",nrow(count_tie_gemeinden)))
  
  #Stimmbeteiligung und Ständemehr
  print(paste0("Stimmbeteiligung: ",results_national$stimmbeteiligungInProzent," %"))
  print(paste0("Stände JA: ",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2)))
  print(paste0("Stände NEIN: ",results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2)))
  
  #Datawrapper-Karten aktualisieren
  undertitel_de <- "Es sind noch keine Gemeinden ausgezählt."
  undertitel_fr <- "Aucun résultat n'est encore connu."
  undertitel_it <- "Nessun risultato è ancora noto."

  if (nrow(results_notavailable) == 0) {
    undertitel_de <- paste0("Volk: <b>",
                            round2(results_national$jaStimmenInProzent,1)," %</b> Ja, <b>",
                            round2(100-results_national$jaStimmenInProzent,1)," %</b> Nein.<br>",
                            "Stände: <b>",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2),"</b> Ja, <b>",
                            results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), "</b> Nein.")
    undertitel_de <- gsub("NA","0",undertitel_de)
    
    undertitel_fr <- paste0("Peuple: <b>",
                            round2(results_national$jaStimmenInProzent,1)," %</b> oui, <b>",
                            round2(100-results_national$jaStimmenInProzent,1)," %</b> non.<br>",
                            "Cantons: <b>",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2),"</b> oui, <b>",
                            results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), "</b> non.")
    undertitel_fr <- gsub("NA","0",undertitel_fr)
    
    undertitel_it <- paste0("Popolo: <b>",
                            round2(results_national$jaStimmenInProzent,1)," %</b> sì, <b>",
                            round2(100-results_national$jaStimmenInProzent,1)," %</b> no.<br>",
                            "Cantoni: <b>",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2),"</b> sì, <b>",
                            results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), "</b> no.")
    undertitel_it <- gsub("NA","0",undertitel_it)
  
  } else if (sum(results$Gebiet_Ausgezaehlt) > 0 ) {
    
    undertitel_de <- paste0("Es sind <b>",sum(results$Gebiet_Ausgezaehlt),"</b> von <b>",nrow(results),
                            "</b> Gemeinden ausgezählt.<br>Volk: <b>",
                            round2(results_national$jaStimmenInProzent,1)," %</b> Ja, <b>",
                            round2(100-results_national$jaStimmenInProzent,1)," %</b> Nein.<br>",
                            "Stände: <b>",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2),"</b> Ja, <b>",
                            results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), "</b> Nein.")
    undertitel_de <- gsub("NA","0",undertitel_de)

    undertitel_fr <- paste0("Les résultats de <b>",sum(results$Gebiet_Ausgezaehlt),"</b> des <b>",nrow(results),
                            "</b> communes sont connus. Peuple: <b>",
                            round2(results_national$jaStimmenInProzent,1)," %</b> oui, <b>",
                            round2(100-results_national$jaStimmenInProzent,1)," %</b> non.<br>",
                            "Cantons: <b>",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2),"</b> oui, <b>",
                            results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), "</b> non.")
    undertitel_fr <- gsub("NA","0",undertitel_fr)
    
    undertitel_it <- paste0("I risultati di <b>",sum(results$Gebiet_Ausgezaehlt),"</b> dei <b>",nrow(results),
                            "</b> comuni sono noti. Popolo: <b>",
                            round2(results_national$jaStimmenInProzent,1)," %</b> sì, <b>",
                            round2(100-results_national$jaStimmenInProzent,1)," %</b> no.<br>",
                            "Cantoni: <b>",results_national$jaStaendeGanz+(results_national$jaStaendeHalb/2),"</b> sì, <b>",
                            results_national$neinStaendeGanz+(results_national$neinStaendeHalb/2), "</b> no.")
    undertitel_it <- gsub("NA","0",undertitel_it)

  }  

  datawrapper_codes_vorlage <- datawrapper_codes %>%
    filter(Vorlage == vorlagen_short[i],
           Typ == "Schweizer Gemeinden Karte")

    #Karten Gemeinden
    dw_edit_chart(datawrapper_codes_vorlage$ID[1],intro=undertitel_de,annotate=paste0("Letzte Aktualisierung: ",format(Sys.time(),"%d.%m.%Y %H:%M Uhr")))
    dw_publish_chart(datawrapper_codes_vorlage$ID[1])
    
    dw_edit_chart(datawrapper_codes_vorlage$ID[2],intro=undertitel_fr,annotate=paste0("dernière mise à jour: ",format(Sys.time(),"%d.%m.%Y %Hh%M")))
    dw_publish_chart(datawrapper_codes_vorlage$ID[2])
    
    dw_edit_chart(datawrapper_codes_vorlage$ID[3],intro=undertitel_it,annotate=paste0("Ultimo aggiornamento: ",format(Sys.time(),"%d.%m.%Y %H:%M")))
    dw_publish_chart(datawrapper_codes_vorlage$ID[3])
    
