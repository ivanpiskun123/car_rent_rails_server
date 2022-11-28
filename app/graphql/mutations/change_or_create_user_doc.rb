module Mutations
  class ChangeOrCreateUserDoc < BaseMutation

    argument :image_url, String, required: true
    argument :user_id, Int, required: true

    field :document, Types::DocumentType, null: true
    field :errors, [String], null: false

    def resolve(user_id:, image_url:)
      begin
        user = User.find(user_id)
        if user_document = user.document
          user_document.update(status: 1)
          if user_document.image.nil?
            Image.create(
              reference_type: "Document",
              reference_id: user_document.id,
              image_url: image_url
            )
          else
            user_document.image.update(image_url: image_url)
          end

        else
          user_document = Document.create(
            user_id: user_id,
            status: 1
          )
          Image.create(
            reference_type: "Document",
            reference_id: user_document.id,
            image_url: image_url
          )
        end
        { document: user_document, errors: [] }
      rescue => error
        { document: nil, errors: error.message }
      end
    end
  end
end
