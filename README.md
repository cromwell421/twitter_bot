# Atlanta Falcons Twitter Bot
This rep shows how to create a twitter bot to retweet twitter posts. It was borrowed heavily from Matt's [LondonMapBot](https://www.rostrum.blog/2020/09/21/londonmapbot/) if you want a more detailed guide to rtweet and GitHub Actions. It involves R script, Twitter API access and GitHub Actions.

## Connecting to Twitter's API
Using the [rtweet](https://github.com/ropensci/rtweet) package, you can connect to Twitter's REST API. You can do this by creating a developer account through Twitter and logging the API key and secret.

## Scheduling the Jobs in GitHub Actions
Creating a YAML document in .GitHub/workflows folder, I set the cron job to run every hour. The job then runs the R script which pulls the timeline from all every friend of the bot (accounts the bot follows). It then filters the tweets for Falcons references (Falcon, ATL, Atlanta, etc). If there are any tweets that fall in that criteria, the process will retweet each post.

Do NOT post your API keys to any public repo. GH Secrets works great for storing confidential information and saving as an environmental variable you can reference in your R script.
