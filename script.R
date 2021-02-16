library(tidyverse)


# Create a token containing your Twitter keys
token <-rtweet::create_token(
  app = "atlanta_falcons_bot",  # the name of the Twitter app
  consumer_key = Sys.getenv("CONSUMER_KEY"),      #Use GH Secrets envirnmental variables for token information
  consumer_secret = Sys.getenv("CONSUMER_SECRET"),
  access_token = Sys.getenv("ACCESS_TOKEN"),
  access_secret = Sys.getenv("ACCESS_SECRET")
)

#get list of friends (who the bot follows)
f <- rtweet::get_friends("@BotAtlanta")

#create list of the user id's of the friends
accounts <- c(f$user_id)

#Pull timeline of all friends pulling the latest 10 tweets from each account; excluding replies but including retweets
tweets <- rtweet::get_timeline(accounts, n= 10, exclude_replies = TRUE)

#Print the number of tweets pulled and the timestamps
print(paste0("Number of Tweets Pulled:     ", nrow(tweets)))
print(paste0("Latest Date of Tweets:     ", max(tweets$created_at)))

#Filter tweets to those within the last hour
tweets <-  tweets %>% 
  filter(as.numeric(difftime(lubridate::now(tzone = 'UTC'), created_at, units = 'mins')) <= 60) #difference is in minutes is less than equal 60 seconds

#print the number of tweets in last hour and the timestamps
print(paste0("Number of Tweets Filtered in Past Hour:     ", nrow(tweets)))
print(paste0("Latest Date of Tweets:     ", max(tweets$created_at)))
print(paste0("Oldest Date of Tweets:     ", min(tweets$created_at)))

#falcons related keywords to pull off of
falcons <- 'Falcons|Atlanta|ATL |ATLvs|Ridley|Julio|Falcon|Matt Ryan|Foye|AJ Terrell|Gurley|Arthur Blank|Fontenot|Arthur Smith|Dean Pees|Grady|G. Jarrett|J. Jones|M. Ryan|Deion Jones|D. Jones|Hurst|Keanu Neal|K. Neal'

#filter tweets to just falcons related
falcons_post <- tweets %>% 
  filter(str_detect(text, regex(falcons, ignore_case = T)))

print(paste0("Number of Falcons Tweets:     ", nrow(falcons_post)))


#post tweet using retweet_id equal to the status id
if (nrow(falcons_post) > 0) {
for (i in 1:nrow(falcons_post)) {
  rtweet::post_tweet(retweet_id = falcons_post$status_id[i])
}
}

