for (i in 1:length(vorlagen_short)) {

  cat(paste0("\nErmittle Daten für folgende Vorlage: ",vorlagen$text[i],"\n"))
  
  ###Nationale Resultate aus JSON auslesen
  results_national <- get_results(json_data,i,level="national")

  if(vorlagen$type[i] == "initiative") {
  results_national_special_initiative <- get_results(json_data,i,level="national") 
  results_national_special_gegenvorschlag <- get_results(json_data,i+1,level="national")
  results_national_special_stichentscheid <- get_results(json_data,i+2,level="national")
  }  

  ###Resultate aus JSON auslesen für Gemeinden
  results <- get_results(json_data,i)

  #Daten anpassen Gemeinden
  results <- treat_gemeinden(results)
  results <- format_data_g(results)

  #Kantonsdaten hinzufügen
  results_kantone <- get_results(json_data,i,"cantonal")
  
  Ja_Stimmen_Kanton <- results_kantone %>%
    select(Kantons_Nr,jaStimmenInProzent) %>%
    rename(Ja_Stimmen_In_Prozent_Kanton = jaStimmenInProzent) %>%
    mutate(Highest_Yes_Kant = FALSE,
           Highest_No_Kant = FALSE)
  
  results <- merge(results,Ja_Stimmen_Kanton)
  results_all <- results
  
  #Alle Daten speichern
  write.csv(results_all,paste0("Output_Switzerland/",vorlagen_short[i],"_all_data.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")

  #Wie viele Gemeinden sind ausgezählt
  cat(paste0(sum(results$Gebiet_Ausgezaehlt)," Gemeinden sind ausgezählt.\n"))

  #Neue Variablen
  results <- results %>%
    mutate(Ja_Nein = NA,
           Oui_Non = NA,
           Unentschieden = NA,
           Einstimmig_Ja = NA,
           Einstimmig_Nein = NA,
           kleine_Gemeinde = NA,
           Storyboard = NA,
           Text_d = "Die Resultate dieser Gemeinde sind noch nicht bekannt.",
           Text_f = "Les résultats ne sont pas encore connus dans cette commune.",
           Text_i = "I risultati di questo comune non sono ancora noti.")
  
  #Spezialfälle
  hist_check <- FALSE
  hist_several_check <- FALSE
  other_check <- FALSE
  
  if(vorlagen$type[i] == "initiative") {
    
    #Gegenvorschlag hinzufügen
    results_gegenvorschlag <- get_results(json_data,i+1)
    results_gegenvorschlag$neinStimmenInProzent <- 100-results_gegenvorschlag$jaStimmenInProzent
    results_gegenvorschlag <- results_gegenvorschlag[,c(3:6,11,24)]
    
    colnames(results_gegenvorschlag) <- c("Gebiet_Ausgezaehlt_Gegenvorschlag","Ja_Prozent_Gegenvorschlag","Ja_Absolut_Gegenvorschlag","Nein_Absolut_Gegenvorschlag",
                                          "Gemeinde_Nr","Nein_Prozent_Gegenvorschlag")
    
    results <- merge(results,results_gegenvorschlag)
    
    #Stichentscheid hinzufügen
    results_stichentscheid <- get_results(json_data,i+2)
    results_stichentscheid$neinStimmenInProzent <- 100-results_stichentscheid$jaStimmenInProzent
    results_stichentscheid  <- results_stichentscheid[,c(3:4,11,24)]
    colnames(results_stichentscheid) <- c("Gebiet_Ausgezaehlt_Stichentscheid","Stichentscheid_Zustimmung_Hauptvorlage","Gemeinde_Nr","Stichentscheid_Zustimmung_Gegenvorschlag")
    results <- merge(results,results_stichentscheid)
  }  

  #Ausgezählte Gemeinden auswählen
  if (vorlagen$type[i] == "initiative") {
    results_notavailable <- results[results$Gebiet_Ausgezaehlt == FALSE |
                                      results$Gebiet_Ausgezaehlt_Gegenvorschlag == FALSE |
                                      results$Gebiet_Ausgezaehlt_Stichentscheid == FALSE,]
    
    results <- results[results$Gebiet_Ausgezaehlt == TRUE &
                         results$Gebiet_Ausgezaehlt_Gegenvorschlag == TRUE &
                         results$Gebiet_Ausgezaehlt_Stichentscheid == TRUE,] 
  } else {  
  results_notavailable <- results[results$Gebiet_Ausgezaehlt == FALSE,]
  results <- results[results$Gebiet_Ausgezaehlt == TRUE,]
  }

  
  #Sind schon Daten vorhanden?
  if (nrow(results) > 0) {
    
    #Daten anpassen
    results <- augment_raw_data(results)
    if (vorlagen$type[i] == "initiative") {
      results <- special_intro(results)
    } else {
      
    #Intros generieren
    results <- normal_intro(results)
    
    #LENA-Classics (falls alle Gemeinden ausgezählt):
    if (nrow(results_notavailable) == 0) {
      results <- lena_classics(results)
    }  
  
    #Special Vergleich mit anderer Abstimmung am selben Datum
    if (votes_metadata_CH$remarks[i] == "other_comparison_first" || votes_metadata_CH$remarks[i] == "other_comparison_second") { 
    other_check <- TRUE
    if (votes_metadata_CH$remarks[i] == "other_comparison_first") {
      results_othervote <- get_results(json_data,i+1)
    } else if (votes_metadata_CH$remarks[i] == "other_comparison_second") {
      results_othervote <- get_results(json_data,i-1)
    }
    results_othervote <- results_othervote %>%
      select(Gemeinde_Nr,
             jaStimmenInProzent) %>%
      rename(Other_Ja_Stimmen_In_Prozent = jaStimmenInProzent) %>%
      mutate(Other_Nein_Stimmen_In_Prozent = 100-Other_Ja_Stimmen_In_Prozent)
    
    results <- merge(results,results_othervote,all.x = TRUE)
    results <- other_storyfinder(results)
    }
    

    #Historischer Vergleich (falls vorhanden)
    if (votes_metadata_CH$remarks[i] == "history_comparison") {
      hist_check <- TRUE 
      results <- merge(results,data_hist,all.x = TRUE)
      results <- hist_storyfinder(results)
    }
    
    if (votes_metadata_CH$remarks[i] == "history_comparison_special") {
      hist_check <- TRUE 
      results <- merge(results,data_hist,all.x = TRUE)
      results <- hist_storyfinder_special(results)
    }

    if (votes_metadata_CH$remarks[i] == "history_comparison_several") {
      hist_check <- TRUE
      hist_several_check <- TRUE
      data_hist_1 <- format_data_hist(daten_covid1_bfs)
      data_hist_1 <- data_hist_1 %>%
        select(Gemeinde_Nr,Hist_Ja_Stimmen_In_Prozent) %>%
        rename(Hist1_Ja_Stimmen_In_Prozent = Hist_Ja_Stimmen_In_Prozent)
      data_hist_2 <- format_data_hist(daten_covid2_bfs)
      data_hist_2 <- data_hist_2 %>%
        select(Gemeinde_Nr,Hist_Ja_Stimmen_In_Prozent) %>%
        rename(Hist2_Ja_Stimmen_In_Prozent = Hist_Ja_Stimmen_In_Prozent)
      results <- merge(results,data_hist_1,all.x = TRUE)
      results <- merge(results,data_hist_2,all.x = TRUE)
      results <- hist_storyfinder_several(results)
    }

    #Vergleich innerhalb des Kantons (falls alle Daten vom Kanton vorhanden)
    if (votes_metadata_CH$remarks[i] == "canton_comparison") {
      #Falls mindestens ein Kanton ausgezählt -> Stories für die Kantone finden
      if (length(unique(results_notavailable$Kantons_Nr)) < 26) {
        results <- kanton_storyfinder(results)
      }
    }
    
    }

    ###Storybuilder
    if (grepl("counterproposal|casting_vote",vorlagen$type[i]) == FALSE) {
    #Textvorlagen laden
    Textbausteine <- as.data.frame(read_excel(paste0("Texte/Textbausteine_LENA_",abstimmung_date,".xlsx"), 
                                              sheet = vorlagen_short[i]))
    cat("Textvorlagen geladen\n\n")

    #Texte einfügen
    results <- build_texts(results)
  
    #Variablen ersetzen 
    if (vorlagen$type[i] == "initiative") {
    results <- replace_variables_special(results)  
    } else {  
    results <- replace_variables(results)
    }
    
    ###Texte anpassen und optimieren
    results <- excuse_my_french(results)
    }
  }
  
  ###Ausgezählte und nicht ausgezählte Gemeinden wieder zusammenführen -> Immer gleiches Format für Datawrapper
  if (nrow(results_notavailable) > 0) {
    
    results_notavailable$Ja_Stimmen_In_Prozent <- 0
    results_notavailable$Nein_Stimmen_In_Prozent <- 0
    results_notavailable$Gemeinde_color <- 50
    
    if ((hist_check == TRUE) & (hist_several_check == FALSE)) {
      results_notavailable$Hist_Ja_Stimmen_In_Prozent <- NA
      results_notavailable$Hist_Ja_Stimmen_Absolut <- NA
      results_notavailable$Hist_Nein_Stimmen_In_Prozent <- NA
      results_notavailable$Hist_Nein_Stimmen_Absolut <- NA
      
    }
    
    if ((hist_check == TRUE) & (hist_several_check == TRUE)) {
      results_notavailable$Hist1_Ja_Stimmen_In_Prozent <- NA
      results_notavailable$Hist2_Ja_Stimmen_In_Prozent <- NA
    }
    
    if (other_check == TRUE) {
      results_notavailable$Other_Ja_Stimmen_In_Prozent <- NA
      results_notavailable$Other_Nein_Stimmen_In_Prozent <- NA
    }

    results <- rbind(results,results_notavailable) %>%
      arrange(Gemeinde_Nr)
    
  }

###Texte speichern
if (save_texts == TRUE) {
texts <- results %>%
  select(Gemeinde_KT_d,
         Storyboard,
         Text_d,
         Text_f,
         Text_i)

library(xlsx)
write.xlsx(texts,paste0("./Texte/",vorlagen_short[i],"_texte.xlsx"),row.names = FALSE)
}  
  ###Output generieren für Datawrapper
  if (vorlagen$type[i] == "initiative") {
  source("./Nationale_Abstimmungen/outputs_gemeinden_special.R", encoding="UTF-8")  
  } else if (grepl("counterproposal|casting_vote",vorlagen$type[i]) == FALSE) {  
  source("./Nationale_Abstimmungen/outputs_gemeinden.R", encoding="UTF-8")
  }  
  source("./Nationale_Abstimmungen/outputs_kantone.R", encoding="UTF-8")  
  if (SPECIAL_AREAS == TRUE) {
  source("./Nationale_Abstimmungen/outputs_einzugsgebiete.R", encoding = "UTF-8")
  }
    
  ###Eintrag für Uebersicht
  source("./Nationale_Abstimmungen/entry_overview.R", encoding="UTF-8")
}
