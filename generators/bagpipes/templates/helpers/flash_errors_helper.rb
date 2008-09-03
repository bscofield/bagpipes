module FlashErrorsHelper
  def flash_divs
    markup = [:notice, :error].inject('') do |markup, key|
      markup = content_tag(:div, h(flash[key]), :class => "flash #{key}") unless flash[key].blank?
      markup
    end

    if flash[:form_error]
      markup << content_tag(:div, grab_errors_for_flash(flash[:form_error]), :class => "flash error")
    end

    markup
  end

  def grab_errors_from_object(obj)
    obj.errors.full_messages.map {|e| "<li>#{e}</li>" }.join("\n")
  end

  def grab_errors_for_flash(obj, specific = [])
    markup = "<p>We're sorry, but we couldn't save your submission. Please take a look at the following:</p><ul class='error-list'>"
    markup << (specific.empty? ? grab_errors_from_object(obj) : specific.map {|e| "<li>#{e}</li>" }.join("\n"))
    markup << '</ul>'
  end
end