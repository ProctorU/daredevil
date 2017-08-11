= Daredevil

This gem provides insight to api errors by providing messages for all general server error response codes.

It is inspired by the [json_api_responders](https://github.com/stankec/json_api_responders) gem.

## Installation

Add this line to your application's Gemfile:

```
gem 'daredevil'
```

And then execute:

    $ bundle

Inside your base controller, include the module:

```
module Api
  module V1
    class BaseController < ApplicationController
      include Daredevil
    end
  end
end
```


= License

This project rocks and uses MIT-LICENSE.
