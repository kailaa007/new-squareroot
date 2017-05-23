module ApplicationHelper

  def get_ques_type(number)
    if number == 1
      'True/False'
    elsif number == 2
      'Single Select'
    elsif number == 3
      'Multiple Select'
    elsif number == 4
      'Detail Field'
    elsif number == 5
      'Email Field'
    elsif number == 6
      'Input Field'
    end  
  end

  def title(text = nil)
    if text
      content_for :title, text
    else
      content_for?(:title) ? content_for(:title) : config.site_name
    end
  end

  def meta_keywords(tags = nil)
    if tags.present?
      content_for :meta_keywords, tags
    else
      content_for?(:meta_keywords) ? [content_for(:meta_keywords), config.meta_keywords].join(', ') : config.meta_keywords
    end
  end

  def meta_description(desc = nil)
    if desc.present?
      content_for :meta_description, desc
    else
      content_for?(:meta_description) ? content_for(:meta_description) : config.meta_description
    end
  end

  def render_flash
    return unless flash.any?
    render partial: 'shared/flash', locals: { flash: flash }
  end

  def red_or_green boolean
    boolean ? 'green' : 'red'
  end

  def yes_or_no boolean
    boolean ? 'Yes' : 'No'
  end

  def maybe item
    item.presence || '-'
  end

  def percentage amount
    number_to_percentage amount, precision: 2
  end

  def interchange_tag image, opts = {}
    standard_path = image_path(image)
    retina_path   = opts[:retina] || image_path("#{image.split('.').first}-retina.#{image.split('.').last}")
    opts[:data]   ||= {}
    opts[:data].merge!(interchange: "[#{standard_path} (default)], [#{retina_path} (retina)]")
    content_tag(:img, opts) {}
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  private

  def config
    Rails.application.secrets
  end

end