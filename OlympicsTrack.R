oTrack<-read.csv(file="C:/Bits/GitHub/TrackResults/results.csv")
plot(oTrack %>% 
         select( Gender, 
                 Event, 
                 Year,
                 Medal, 
                 Result) %>% 
         filter( Gender == "M") %>%  
         filter( Medal  == "G" ) %>%
         filter( Event  == "1500M Men") %>% 
         arrange(., Result) %>%
         select(Result)
)

