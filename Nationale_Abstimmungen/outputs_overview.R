#Uebersicht für Datawrapper
data_overview <- data_overview[-1,]
write.csv(data_overview,"Output_Overviews/Uebersicht_dw.csv", na = "", row.names = FALSE, fileEncoding = "UTF-8")

#Charts Uebersicht
datawrapper_codes_overview <- datawrapper_codes %>%
  filter(Typ == "Uebersicht")

#DEUTSCH
dw_data_to_chart(data_overview,datawrapper_codes_overview$ID[1])
if (nrow(results_notavailable) == 0) {
  
if (length(vorlagen_short) > 1 ) {  
titel_de <- paste0("Die Abstimmungen vom ",day(voting_date),". ",monate_de[month(voting_date)]," ",year(voting_date)," in der Übersicht") 
} else {
titel_de <- paste0("Die Abstimmung vom ",day(voting_date),". ",monate_de[month(voting_date)]," ",year(voting_date))   
}  

dw_edit_chart(datawrapper_codes_overview$ID[1],
              title = titel_de,
              intro = "")
} else {
dw_edit_chart(datawrapper_codes_overview$ID[1],intro=paste0("Letzte Aktualisierung: ",format(Sys.time(),"%H:%M Uhr")))
}  
dw_publish_chart(datawrapper_codes_overview$ID[1])

#FRANZOESICH
dw_data_to_chart(data_overview,datawrapper_codes_overview$ID[2])
if (nrow(results_notavailable) == 0) {
  if (length(vorlagen_short) > 1 ) {    
titel_fr <- paste0("Les résultats des votes du ",day(voting_date)," ",monate_fr[month(voting_date)]," ",year(voting_date))
} else {
titel_fr <- paste0("Le résultat du vote du ",day(voting_date)," ",monate_fr[month(voting_date)]," ",year(voting_date))  
}  
dw_edit_chart(datawrapper_codes_overview$ID[2],
                title = titel_fr,
                intro = "")
} else {  
dw_edit_chart(datawrapper_codes_overview$ID[2],intro=paste0("Dernière mise à jour: ",format(Sys.time(),"%Hh%M")))
}
dw_publish_chart(datawrapper_codes_overview$ID[2])

#ITALIENISCH
dw_data_to_chart(data_overview,datawrapper_codes_overview$ID[3])
if (nrow(results_notavailable) == 0) {
  if (length(vorlagen_short) > 1 ) {  
titel_it <- paste0("I risultati delle votazioni del ",day(voting_date)," ",monate_it[month(voting_date)]," ",year(voting_date))
} else {
titel_it <- paste0("Il risultato della votazioni del ",day(voting_date)," ",monate_it[month(voting_date)]," ",year(voting_date))  
}  
dw_edit_chart(datawrapper_codes_overview$ID[3],
              title = titel_it,
              intro = "")
} else {  
dw_edit_chart(datawrapper_codes_overview$ID[3],intro=paste0("Ultimo aggiornamento: ",format(Sys.time(),"%H:%M")))  
}  
dw_publish_chart(datawrapper_codes_overview$ID[3])

#Output Overall Texts
# for (i in 1:length(vorlagen_short)) {
# data_de <- read.csv(paste0("./Output_Switzerland/",vorlagen_short[i],"_dw_de.csv"))
# data_de <- data_de %>%
#   select(Gemeinde_de,Text_de)
# data_fr <- read.csv(paste0("./Output_Switzerland/",vorlagen_short[i],"_dw_fr.csv"))
# data_fr <- data_fr %>%
#   select(Gemeinde_fr,Text_fr)
# data_it <- read.csv(paste0("./Output_Switzerland/",vorlagen_short[i],"_dw_it.csv"))
# data_it <- data_it %>%
#   select(Gemeinde_it,Text_it)
# 
# data_all <- cbind(data_de,data_fr,data_it)
# write.csv(data_all,paste0("Output_Switzerland/",vorlagen_short[i],"_all_texts.csv"), na = "", row.names = FALSE, fileEncoding = "UTF-8")
# }  

