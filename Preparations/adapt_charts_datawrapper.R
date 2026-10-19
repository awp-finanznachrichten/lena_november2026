grafiken_uebersicht <- read_excel("./Data/metadaten_grafiken_eidgenoessische_Abstimmungen.xlsx",sheet=2)

#grafiken_uebersicht <- datawrapper_codes %>%
#  filter(grepl("Kantonale Vorlage",Typ) == TRUE)

grafiken_uebersicht <- datawrapper_codes %>%
  filter(date == "2026-09-27",
         #Vorlage == "CH_Individualbesteuerung",
         #Sprache == "de-DE",
         grepl("Kanton ",Typ) == TRUE)

View(grafiken_uebersicht)
grafiken_uebersicht
for (i in 1:nrow(grafiken_uebersicht)) {

metadata_chart <- dw_retrieve_chart_metadata(grafiken_uebersicht$ID[i])


dw_edit_chart(grafiken_uebersicht$ID[i],
              visualize = list("mapView" = "crop",
                               "hide-empty-regions" = TRUE))

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