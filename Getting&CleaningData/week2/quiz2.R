##Q1
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "064b3cb69291d3c4c2f0",
                   secret = "1489e975a817e1657a9b93b12a90b4cef588e386")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos")
#stop_for_status(req)
json_data<- jsonlite::fromJSON(toJSON(content(req)))
print (json_data[json_data$name=="datasharing","created_at"])
###Q4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
my_lines=readLines(con)
close(con)
print ("Q4 ******")
print(nchar(my_lines[10]))
print(nchar(my_lines[20]))
print(nchar(my_lines[30]))
print(nchar(my_lines[100]))
print ("Q4 ******")
###Q5
