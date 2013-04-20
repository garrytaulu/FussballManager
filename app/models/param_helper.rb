class ParamHelper

  def self.handle_only_param(options = {})
    only = options[:only]

    if only

      only = only.to_s.split(',')
      only = only.map(&:lstrip)
    end

    options[:only] = only
  end
end