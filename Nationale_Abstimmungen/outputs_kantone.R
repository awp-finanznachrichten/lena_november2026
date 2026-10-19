###Output generieren für Datawrapper
  #Output Abstimmungen Kantone
  output_dw_kantone <- get_output_kantone(results)

  output_dw_kantone <- output_dw_kantone %>%
    left_join(meta_kt,join_by(Kantons_Nr == bfs_ID)) %>%
    select(Kantons_Nr,Kanton_d,Kanton_f,Kanton_i,
           Ja_Stimmen_In_Prozent_Kanton,Nein_Stimmen_In_Prozent_Kanton,
           Kanton_color,Gemeinden_overall,Gemeinden_counted,Legende,
           Text_de,Text_fr,Text_it,link_wappen)
  
  write.csv(output_dw_kantone,paste0("Output_Switzerland/",vorlagen_short[i],"_dw_kantone.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
  
  cat(paste0("\nGenerated output for Vorlage ",vorlagen_short[i],"\n"))
  
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
             Typ == "Schweizer Kantone Karte")

    #Karten Kantone
    if (grepl("initiative|counterproposal|casting_vote",vorlagen$type[i]) == FALSE) {
  
    dw_edit_chart(datawrapper_codes_vorlage$ID[1],intro=undertitel_de,annotate=paste0("Letzte Aktualisierung: ",format(Sys.time(),"%d.%m.%Y %H:%M Uhr")))
    dw_publish_chart(datawrapper_codes_vorlage$ID[1])
    
    dw_edit_chart(datawrapper_codes_vorlage$ID[2],intro=undertitel_fr,annotate=paste0("dernière mise à jour: ",format(Sys.time(),"%d.%m.%Y %Hh%M")))
    dw_publish_chart(datawrapper_codes_vorlage$ID[2])
    
    dw_edit_chart(datawrapper_codes_vorlage$ID[3],intro=undertitel_it,annotate=paste0("Ultimo aggiornamento: ",format(Sys.time(),"%d.%m.%Y %H:%M")))
    dw_publish_chart(datawrapper_codes_vorlage$ID[3])
    
    } else {
      dw_edit_chart(datawrapper_codes_vorlage$ID[1],annotate=paste0("Letzte Aktualisierung: ",format(Sys.time(),"%d.%m.%Y %H:%M Uhr")))
      dw_publish_chart(datawrapper_codes_vorlage$ID[1])
      
      dw_edit_chart(datawrapper_codes_vorlage$ID[2],annotate=paste0("dernière mise à jour: ",format(Sys.time(),"%d.%m.%Y %Hh%M")))
      dw_publish_chart(datawrapper_codes_vorlage$ID[2])
      
      dw_edit_chart(datawrapper_codes_vorlage$ID[3],annotate=paste0("Ultimo aggiornamento: ",format(Sys.time(),"%d.%m.%Y %H:%M")))
      dw_publish_chart(datawrapper_codes_vorlage$ID[3])  
    }  
  
