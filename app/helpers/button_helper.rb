# frozen_string_literal: true

module ButtonHelper
  def back_button
    link_to 'javascript:history.back()', class: 'btn btn-sm btn-white', title: t('back') do
      concat tag.i(class: 'fas fa-chevron-left')
      concat " #{t('back')}"
    end
  end

  def create_button(*path)
    path = path.flatten
    link_to '', new_polymorphic_path(path), class: 'btn btn-sm btn-success fas fa-plus', title: t('new'),
                                            data: { turbo: true, turbo_frame: 'modal' }
  end

  def show_button(*path)
    path = path.flatten
    link_to '', polymorphic_path(path), class: 'btn btn-sm btn-primary fas fa-eye', title: t('show')
  end

  def show_modal_button(*path)
    path = path.flatten
    link_to '', polymorphic_path(path), class: 'btn btn-sm btn-primary fas fa-eye', title: t('show'),
                                        data: { turbo: true, turbo_frame: 'modal' }
  end

  def edit_button(*path)
    path = path.flatten
    link_to '', edit_polymorphic_path(path), class: 'btn btn-sm btn-warning fas fa-edit', title: t('edit'),
                                             data: { turbo: true, turbo_frame: 'modal' }
  end

  def destroy_button(*path)
    path = path.flatten
    link_to '', polymorphic_path(path), data: { turbo_method: :delete, turbo_confirm: 'Are you sure?' },
                                        class: 'btn btn-sm btn-danger fas fa-trash', title: t('delete')
  end

  def activate_button(*path)
    path = path.flatten
    link_to '', polymorphic_path(path, action: :activate), class: 'btn btn-sm btn-success fas fa-play',
                                                           title: t('activate'),
                                                           data: {
                                                             turbo_method: :patch, turbo_confirm: t('are_you_sure')
                                                           }
  end

  def deactivate_button(*path)
    path = path.flatten
    link_to '', polymorphic_path(path, action: :deactivate), class: 'btn btn-sm btn-danger fas fa-stop',
                                                             title: t('deactivate'),
                                                             data: {
                                                               turbo_method: :patch, turbo_confirm: t('are_you_sure')
                                                             }
  end

  def action_button(*path, action: nil, icon: '', confirm: false, label: '', type: 'primary', method: :patch, # rubocop:disable Metrics/ParameterLists
                    turbo: false)
    path = path.flatten
    data_options = { turbo_method: method }
    data_options[:turbo_frame] = 'modal' if turbo
    data_options[:turbo_confirm] = t('are_you_sure') if confirm
    link_to label, polymorphic_path(path, action: action), class: "btn btn-sm btn-#{type} fas #{icon}",
                                                           data: data_options, title: t(action)
  end
end
