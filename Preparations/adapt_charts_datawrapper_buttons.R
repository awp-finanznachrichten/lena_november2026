datawrapper_codes_selection <- datawrapper_codes %>%
  filter(Vorlage == "CH_Bargeld",
         grepl("Kanton",Typ) == TRUE) %>%
  .[1:120,]

###Karten Gemeinden
datawrapper_codes_vorlage_overview <- datawrapper_codes_selection %>%
  filter(grepl("Overview",Typ) == TRUE)
datawrapper_codes_vorlage_initiative <- datawrapper_codes_selection %>%
  filter(grepl("Initiative",Typ) == TRUE)
datawrapper_codes_vorlage_gegenvorschlag <- datawrapper_codes_selection %>%
  filter(grepl("Gegenvorschlag",Typ) == TRUE)
datawrapper_codes_vorlage_stichentscheid <- datawrapper_codes_selection %>%
  filter(grepl("Stichentscheid",Typ) == TRUE)


for (r in 1:nrow(datawrapper_codes_vorlage_overview)) {
  if (datawrapper_codes_vorlage_overview$Sprache[r] == "de-DE") {
    dw_edit_chart(datawrapper_codes_vorlage_overview$ID[r],
                  intro=paste0('
<span style="line-height:30px">
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Übersicht&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Initiative&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Gegenvorschlag</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Stichentscheid</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_overview$ID[r])
  } else if (datawrapper_codes_vorlage_overview$Sprache[r] == "fr-CH") {
    dw_edit_chart(datawrapper_codes_vorlage_overview$ID[r],
                  intro=paste0('
<span style="line-height:30px">
<a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;aperçu&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;initiative&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> contre-proposition</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> question subsidiaire</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_overview$ID[r])
  } else {
    dw_edit_chart(datawrapper_codes_vorlage_overview$ID[r],
                  intro=paste0('
<span style="line-height:30px">
<a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;panoramica&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;iniziativa&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> controproposta</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> domanda risolutiva</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_overview$ID[r]) 
  }  
}

for (r in 1:nrow(datawrapper_codes_vorlage_initiative)) {
  if (datawrapper_codes_vorlage_initiative$Sprache[r] == "de-DE") {
    dw_edit_chart(datawrapper_codes_vorlage_initiative$ID[r],
                  intro=paste0('
<span style="line-height:30px">
<a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Übersicht&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Initiative&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Gegenvorschlag</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Stichentscheid</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_initiative$ID[r])
  } else if (datawrapper_codes_vorlage_initiative$Sprache[r] == "fr-CH") {
    dw_edit_chart(datawrapper_codes_vorlage_initiative$ID[r],
                  intro=paste0('
<span style="line-height:30px">
<a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;aperçu&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;initiative&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> contre-proposition</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> question subsidiaire</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_initiative$ID[r])
  } else {
    dw_edit_chart(datawrapper_codes_vorlage_initiative$ID[r],
                  intro=paste0('
<span style="line-height:30px">
<a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;panoramica&nbsp;&nbsp;</a> &nbsp;
  <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;iniziativa&nbsp;&nbsp;</a> &nbsp;
                                     <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> controproposta</a> &nbsp;
                                   <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> domanda risolutiva</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_initiative$ID[r])
    
  }  
}

for (r in 1:nrow(datawrapper_codes_vorlage_gegenvorschlag)) {
  if (datawrapper_codes_vorlage_gegenvorschlag$Sprache[r] == "de-DE") {
    dw_edit_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r],
                  intro=paste0('
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Übersicht&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Initiative&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Gegenvorschlag</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Stichentscheid</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r])
  } else if (datawrapper_codes_vorlage_gegenvorschlag$Sprache[r] == "fr-CH") {
    dw_edit_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r],
                  intro=paste0('
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;aperçu&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;initiative&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> contre-proposition</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> question subsidiaire</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r])
  } else {
    dw_edit_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r],
                  intro=paste0('
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;panoramica&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;iniziativa&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> controproposta</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> domanda risolutiva</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_gegenvorschlag$ID[r])
    
  }  
}

for (r in 1:nrow(datawrapper_codes_vorlage_stichentscheid)) {
  if (datawrapper_codes_vorlage_stichentscheid$Sprache[r] == "de-DE") {
    dw_edit_chart(datawrapper_codes_vorlage_stichentscheid$ID[r],
                  intro=paste0('
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Übersicht&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;Initiative&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Gegenvorschlag</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> Stichentscheid</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_stichentscheid$ID[r])
  } else if (datawrapper_codes_vorlage_gegenvorschlag$Sprache[r] == "fr-CH") {
    dw_edit_chart(datawrapper_codes_vorlage_stichentscheid$ID[r],
                  intro=paste0('
                        <span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;aperçu&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;initiative&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> contre-proposition</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> question subsidiaire</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_stichentscheid$ID[r])
  } else {
    dw_edit_chart(datawrapper_codes_vorlage_stichentscheid$ID[r],
                  intro=paste0('<span style="line-height:30px">
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_overview$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;panoramica&nbsp;&nbsp;</a> &nbsp;
                        <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_initiative$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer">&nbsp;&nbsp;iniziativa&nbsp;&nbsp;</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_gegenvorschlag$ID[r],'/" style="background:#808080; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> controproposta</a> &nbsp;
                      <a target="_self" href="https://datawrapper.dwcdn.net/',datawrapper_codes_vorlage_stichentscheid$ID[r],'/" style="background:#429ddd; padding:4px 6px; border-radius:5px; color:#ffffff; font-weight:400; box-shadow:0px 0px 7px 2px rgba(0,0,0,0.07); cursor:pointer;" rel="nofollow noopener noreferrer"> domanda risolutiva</a> &nbsp;'))
    dw_publish_chart(datawrapper_codes_vorlage_stichentscheid$ID[r])
  }  
}
