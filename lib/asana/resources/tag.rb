### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # A _tag_ is a label that can be attached to any task in Asana. It exists in a
    # single workspace or organization.
    #
    # Tags have some metadata associated with them, but it is possible that we will
    # simplify them in the future so it is not encouraged to rely too heavily on it.
    # Unlike projects, tags do not provide any ordering on the tasks they
    # are associated with.
    class Tag < Resource


      attr_reader :id

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'tags'
        end

        # Creates a new tag in a workspace or organization.
        #
        # Every tag is required to be created in a specific workspace or
        # organization, and this cannot be changed once set. Note that you can use
        # the `workspace` parameter regardless of whether or not it is an
        # organization.
        #
        # Returns the full record of the newly created tag.
        #
        # workspace - [Id] The workspace or organization to create the tag in.
        # data - [Hash] the attributes to post.
        def create(client, workspace:, **data)
          with_params = data.merge(workspace: workspace).reject { |_,v| v.nil? }
          self.new(parse(client.post("/tags", body: with_params)).first, client: client)
        end

        # Creates a new tag in a workspace or organization.
        #
        # Every tag is required to be created in a specific workspace or
        # organization, and this cannot be changed once set. Note that you can use
        # the `workspace` parameter regardless of whether or not it is an
        # organization.
        #
        # Returns the full record of the newly created tag.
        #
        # workspace - [Id] The workspace or organization to create the tag in.
        # data - [Hash] the attributes to post.
        def create_in_workspace(client, workspace:, **data)

          self.new(parse(client.post("/workspaces/#{workspace}/tags", body: data)).first, client: client)
        end

        # Returns the complete tag record for a single tag.
        #
        # id - [Id] The tag to get.
        def find_by_id(client, id)

          self.new(parse(client.get("/tags/#{id}")).first, client: client)
        end

        # Returns the compact tag records for some filtered set of tags.
        # Use one or more of the parameters provided to filter the tags returned.
        #
        # workspace - [Id] The workspace or organization to filter tags on.
        # team - [Id] The team to filter tags on.
        # archived - [Boolean] Only return tags whose `archived` field takes on the value of
        # this parameter.
        def find_all(client, workspace: nil, team: nil, archived: nil, limit: 20)
          params = { workspace: workspace, team: team, archived: archived, limit: limit }.reject { |_,v| v.nil? }
          Collection.new(parse(client.get("/tags", params: params)), type: self, client: client)
        end

        # Returns the compact tag records for all tags in the workspace.
        #
        # workspace - [Id] The workspace or organization to find tags in.
        def find_by_workspace(client, workspace:, limit: 20)
          params = { limit: limit }.reject { |_,v| v.nil? }
          Collection.new(parse(client.get("/workspaces/#{workspace}/tags", params: params)), type: self, client: client)
        end
      end

      # Updates the properties of a tag. Only the fields provided in the `data`
      # block will be updated; any unspecified fields will remain unchanged.
      #
      # When using this method, it is best to specify only those fields you wish
      # to change, or else you may overwrite changes made by another user since
      # you last retrieved the task.
      #
      # Returns the complete updated tag record.
      #
      # data - [Hash] the attributes to post.
      def update(**data)

        refresh_with(parse(client.put("/tags/#{id}", body: data)).first)
      end

      # A specific, existing tag can be deleted by making a DELETE request
      # on the URL for that tag.
      #
      # Returns an empty data record.
      def delete()

        client.delete("/tags/#{id}") && true
      end

    end
  end
end
