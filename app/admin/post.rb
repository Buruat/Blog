ActiveAdmin.register Post do
  permit_params :title, :body, :description, :user_id, :image

  index do
    selectable_column
    id_column
    column :title
    column :body
    column :description
    column :user_id
    column "Image" do |post|
      image_tag(post.image, class: "image-show", height: "100") if post.image.attached?
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :text
      f.input :description, as: :text
      f.input :user_id
      f.input :image
    end
    f.actions
  end
end