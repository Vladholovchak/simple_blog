module Api
  module Controllers
    module Posts
      class Create
        include Api::Action
        include JSONAPI::Hanami::Action

        accept :json

        def call(params)
          user = User.find_or_create_by(login: params[:login])
          post = Post.new(user_id: user.id, user_ip: request.ip,
                          title: params[:title], content: params[:content])
          if post.valid?
            post.save
            self.body = post
            self.status = 200
          else
            self.body = post.errors
            self.status = 400
          end
        end
      end
    end
  end
end
