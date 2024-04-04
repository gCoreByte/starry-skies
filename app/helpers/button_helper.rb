# frozen_string_literal: true

module ButtonHelper
  def back_button
    link_to 'javascript:history.back()', class: 'btn btn-sm btn-white' do
      concat tag.i(class: 'fas fa-chevron-left')
      concat ' Back'
    end
  end

  def create_button(*path)
    path = path.flatten
    link_to '', new_polymorphic_path(path), class: 'btn btn-sm btn-success fas fa-plus',
                                            data: { turbo: true, turbo_frame: 'modal' }
  end

  def show_button(*path)
    path = path.flatten
    link_to '', polymorphic_path(path), class: 'btn btn-primary fas fa-eye'
  end

  def edit_button(*path)
    path = path.flatten
    link_to '', edit_polymorphic_path(path), class: 'btn btn-warning fas fa-edit',
                                             data: { turbo: true, turbo_frame: 'modal' }
  end

  def destroy_button(*path)
    path = path.flatten
    link_to '', polymorphic_path(path), data: { turbo_method: :delete, turbo_confirm: 'Are you sure?' },
                                        class: 'btn btn-danger fas fa-trash'
  end

  def activate_button(*path)
    path = path.flatten
    link_to '', polymorphic_path(path, action: :activate), class: 'btn btn-success fas fa-play',
                                                           data: {
                                                             turbo_method: :patch, turbo_confirm: t('are_you_sure')
                                                           }
  end

  def deactivate_button(*path)
    path = path.flatten
    link_to '', polymorphic_path(path, action: :deactivate), class: 'btn btn-danger fas fa-stop',
                                                             data: {
                                                               turbo_method: :patch, turbo_confirm: t('are_you_sure')
                                                             }
  end
end
