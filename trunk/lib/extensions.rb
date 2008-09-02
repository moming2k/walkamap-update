class Extensions

  ActionView::Helpers::JavaScriptMacrosHelper.class_eval do
    def in_place_editor_field(object, method, tag_options = {}, in_place_editor_options = {})
      tag = ::ActionView::Helpers::InstanceTag.new(object, method, self)
      tag.nil_content_replacement = in_place_editor_options[:nil_content_replacement] || 'Unknown'
      tag_options = {:tag => "span", :id => "#{object}_#{method}_#{tag.object.id}_in_place_editor", :class => "in_place_editor_field"}.merge!(tag_options)
      in_place_editor_options[:url] = in_place_editor_options[:url] || url_for({ :action => "set_#{object}_#{method}", :id => tag.object.id })
      tag.to_content_tag(tag_options.delete(:tag), tag_options) +
      in_place_editor(tag_options[:id], in_place_editor_options)
    end
  end

  ActionView::Helpers::InstanceTag.class_eval do
    attr_writer :nil_content_replacement

    def value
      unless object.nil?
        v = object.send(@method_name)
        if @nil_content_replacement.nil?
          return v
        else
          (v.nil? || v.to_s.strip=='') ? @nil_content_replacement : v
        end
      end
    end
  end

end