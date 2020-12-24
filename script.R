library(tidyverse)


# unlink(Sys.getenv("TWITTER_PAT"))
# Sys.unsetenv("TWITTER_PAT")

# Create a token containing your Twitter keys
token <-rtweet::create_token(
  app = "atlanta_falcons_bot",  # the name of the Twitter app
  consumer_key = Sys.getenv("CONSUMER_KEY"),
  consumer_secret = Sys.getenv("CONSUMER_SECRET"),
  access_token = Sys.getenv("ACCESS_TOKEN"),
  access_secret = Sys.getenv("ACCESS_SECRET")
)

#get list of friends
f <- rtweet::get_friends("@BotAtlanta")

#make list of those friends
accounts <- c(f$user_id)

#Pull timeline all of all friends and filter to those whithin the last 4 hours
tweets <- rtweet::get_timeline(accounts, n= 50, exclude_replies = TRUE) %>% 
  filter(difftime(lubridate::now(tzone = 'UTC'), created_at) < 400)

falcons <- c('Falcons|Atlanta|ATL|Texans|Patriot')
#filter tweets to just falcons related
falcons_post <- rtweet::tweets %>% 
  filter(str_detect(text, falcons))

#post_tweet using retweet_id equalt to the status id
if (nrow(falcons_post) > 0) {
for (i in 1:nrow(falcons_post)) {
  rtweet::post_tweet(retweet_id = falcons_post$status_id[i])
}
}


#if (nrow(falcons_post) > 0) {
#  rtweet::post_tweet(retweet_id = falcons_post$status_id)
#}
#rtweet::post_tweet(retweet_id = falcons_post$status_id)

