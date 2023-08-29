ActiveAdmin.register User do
  permit_params :email, :password

  index do
    selectable_column
    id_column
    column :email
    column :password
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
    end
    f.actions
  end
end