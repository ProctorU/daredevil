# Daredevil

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

## Configuration

If you would like to use serializers instead of jbuilder, you can add a config initializer.

```
Daredevil.configure do |config|
  config.responder_type = :serializers
end
```

## Responses

If a status is not set, the default status will be returned.

### index

    respond_with resource

### show

    respond_with resource

### create

    if resource.valid?
      respond_with resource, status: 201
    else
      respond_with resource, status: 442

### update

    if resource.valid?
      respond_with resource, status: 200
    else
      respond_with resource, status: 442

### destroy

    head status: 204

If serializers are set as the render method, Daredevil will try to infer which serializer _first_ by checking for a namespaced serializer, then fallback to a non-namespaced serializer.

The following example will look for `Api::V1::UserSerializer` first, then if not found will look for `UserSerializer`.

```
module Api
  module V1
    class UserController
      def index
        respond_with @users
      end
    end
  end
end
```

Or, specify a serializer specifically:


```
module Api
  module V1
    class UserController
      def index
        respond_with @users, serializer: KustomUserSerializer
      end
    end
  end
end
```

= License

This project rocks and uses MIT-LICENSE.
