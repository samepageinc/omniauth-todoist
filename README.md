# OmniAuth Todoist 
An OmniAuth strategy for authenticating to [Todoist](https://todoist.com/). To use it you'll need to register an application with [Todoist](https://developer.todoist.com/appconsole.html) to get an OAuth2 Client ID and Secret. More info on what and how you can use Todoist's API can we found [in their api docs](https://developer.todoist.com/).

## Basic Usage

```
use OmniAuth::Builder do
  provider :todoist, ENV['TODOIST_CLIENT_ID'], ENV['TODOIST_CLIENT_SECRET']
end
```

## Copyright 

Copyright (c) 2013 Beeminder inc. See LICENSE.txt for further details.
