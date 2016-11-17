module EnoughWithTheDoubleRenderAlready
  def self.extended(by_controller_class)
    by_controller_class.around_action do |controller, action_block|
      catch(:__rendered_or_redirected__) { action_block.call }
    end
    by_controller_class.prepend(ThrowOnRenderOrRedirect)
  end

  module ThrowOnRenderOrRedirect
    def head(*)
      throw :__rendered_or_redirected__, super
    end
    
    def render(*)
      throw :__rendered_or_redirected__, super
    end
    
    def redirect_to(*)
      throw :__rendered_or_redirected__, super
    end
  end
end
