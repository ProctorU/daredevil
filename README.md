# Daredevil

This gem provides insight to api errors by providing messages for all general server error response codes. It is inspired by the [json_api_responders](https://github.com/stankec/json_api_responders) gem.

## Table of contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#developing)
- [License](#license)
- [Credits](#credits)

## Installation

Add `daredevil` to your application's `Gemfile`:

```ruby
gem 'daredevil'
```

And then execute:

```bash
$ bundle
```

Inside your base controller, include the module:

```ruby
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

```ruby
Daredevil.configure do |config|
  config.responder_type = :serializers
end
```

## Usage

If a status is not set, the default status will be returned.

**index**

```ruby
class ResourceController
  before_action :set_resource

  def index
    respond_with @resources
  end

  def show
    respond_with @resource
  end

  def create
    if resource.save
      respond_with @resource, status: 201
    else
      respond_with @resource, status: 442
    end
  end

  def update
    if resource.valid?
      respond_with @resource, status: 200
    else
      respond_with @resource, status: 442
    end
  end

  def destroy
    head status: 204
  end

  private

  def set_resource; end
end
```

If serializers are set as the render method, Daredevil will try to infer which serializer _first_ by checking for a namespaced serializer, then fallback to a non-namespaced serializer.

The following example will look for `Api::V1::UserSerializer` first, then if not found will look for `UserSerializer`.

```ruby
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


```ruby
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

## License

This project rocks and uses MIT-LICENSE.

## Credits

Storm is maintained and funded by [ProctorU](https://twitter.com/ProctorU),
a simple online proctoring service that allows you to take exams or
certification tests at home.

<br>

<p align="center">
  <a href="https://twitter.com/ProctorUEng">
    <img src="https://s3-us-west-2.amazonaws.com/dev-team-resources/procki-eyes.svg" width=108 height=72>
  </a>

  <h3 align="center">
    <a href="https://twitter.com/ProctorUEng">ProctorU Engineering & Design</a>
  </h3>
</p>
