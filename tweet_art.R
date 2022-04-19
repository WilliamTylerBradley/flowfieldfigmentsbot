library(rtweet)
library(flowfieldfigments)

token <- rtweet::create_token(
  app = "flowfieldfigments",
  consumer_key = Sys.getenv("FFF_TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("FFF_TWITTER_CONSUMER_API_SECRET"),
  access_token = Sys.getenv("FFF_TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("FFF_TWITTER_ACCESS_TOKEN_SECRET"),
  set_renv = FALSE
)

seed <- as.numeric(format(Sys.Date(),"%Y%m%d"))
set.seed(seed)

day <- as.numeric(strftime(Sys.Date(), format = "%j")) + 1

seeds <- sample(1:100000, 3)
size <- sample(seq(50, 1500), 1)
anchor_layout <- c("random", "spiral", "grid")[day %% 3 + 1]
color_scheme <- c("full", "subset")[day %% 2 + 1]
color_subset_center <- runif(1, 0, 360)
color_subset_width <- runif(1, 30, 90)
hue_turn <- runif(1, 0, 360)
media <- c("png", "gif", "png", "gif", "png")[day %% 5 + 1]
movement <- c("", "march", "", "glide", "")[day %% 5 + 1]
alpha_taper <- c("start", "", "end", "", "both")[day %% 5 + 1]

if(media == "png") {
  output_file <- tempfile(fileext = ".png")
  
  flowfieldfigments::create_png(seeds = seeds, 
                                size = size, 
                                anchor_layout = anchor_layout, 
                                hue_turn = hue_turn, 
                                color_scheme = color_scheme,
                                color_subset_center = color_subset_center, 
                                color_subset_width = color_subset_width,
                                alpha_taper = alpha_taper, 
                                output_file = output_file)
} else {
  output_file <- tempfile(fileext = ".gif")
  
  flowfieldfigments::create_gif(seeds = seeds, 
                                size = size, 
                                anchor_layout = anchor_layout, 
                                hue_turn = hue_turn, 
                                color_scheme = color_scheme,
                                color_subset_center = color_subset_center, 
                                color_subset_width = color_subset_width,
                                movement = movement, 
                                output_file = output_file)
}


status <- paste0("set.seed(", seed, ")")
rtweet::post_tweet(status = status,
                   media = output_file,
                   token = token)
