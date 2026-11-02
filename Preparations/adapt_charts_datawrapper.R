grafiken_uebersicht <- read_excel("./Data/metadaten_grafiken_eidgenoessische_Abstimmungen.xlsx",sheet=2)

#grafiken_uebersicht <- datawrapper_codes %>%
#  filter(grepl("Kantonale Vorlage",Typ) == TRUE)

grafiken_uebersicht <- datawrapper_codes %>%
  filter(date == "2026-11-29",
         #Vorlage == "CH_Individualbesteuerung",
         #Sprache == "de-DE",
         grepl("Kanton ",Typ) == TRUE)


for (i in 1:nrow(grafiken_uebersicht)) {

metadata_chart <- dw_retrieve_chart_metadata(grafiken_uebersicht$ID[i])

metadata_chart[["content"]][["metadata"]][["visualize"]][["tooltip"]][["body"]] <- gsub("1[.]3","1.2",metadata_chart[["content"]][["metadata"]][["visualize"]][["tooltip"]][["body"]])
metadata_chart[["content"]][["metadata"]][["visualize"]][["tooltip"]][["body"]] <-gsub("130","150",metadata_chart[["content"]][["metadata"]][["visualize"]][["tooltip"]][["body"]])
adapted_list <- metadata_chart[["content"]][["metadata"]][["visualize"]]

dw_edit_chart(grafiken_uebersicht$ID[i],
              visualize = adapted_list)
                
dw_publish_chart(grafiken_uebersicht$ID[i])
}


for (i in 1:nrow(grafiken_uebersicht)) {
  
  dw_edit_chart(grafiken_uebersicht$ID[i],
                title = paste0(gsub("Kanton ","",grafiken_uebersicht$Typ[i]),
                  ": Individualbesteuerung")
  )
  dw_publish_chart(grafiken_uebersicht$ID[i])
}


View(metadata_chart)
metadata_chart <- dw_retrieve_chart_metadata("zxrLE")


dw_edit_chart("smg56",
              visualize = list("mapView" = "crop",
                               "hide-empty-regions" = TRUE))

dw_publish_chart("smg56")