library(rtweet)
# library(flowfieldfigments)

token <- rtweet::create_token(
  app = "flowfieldfigments",
  consumer_key = Sys.getenv("FFF_TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("FFF_TWITTER_CONSUMER_API_SECRET"),
  access_token = Sys.getenv("FFF_TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("FFF_TWITTER_ACCESS_TOKEN_SECRET"),
  set_renv = FALSE
)

rtweet::post_tweet(status = "This is a test tweet again.",
                   token = token)

