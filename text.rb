require 'text_line'
require 'error'

module TinyBasic

class Text
  attr_reader :lines, :current

  def initialize
    @lines = {}
  end

  def << line
    case line
    when String
      self << TextLine.new(line)
    when TextLine
      @current = line
      unless @current.direct?
        if @current.has_statements?
          lines[line.no] = @current unless @current.direct?
        else 
          lines.delete(@current.no)
        end
      end
      @current
    else
      raise WhatError.new
    end
  end

  def print_list
    lines.keys.sort.each do |no|
      l = lines[no]
      puts "#{l.no} #{l.statements}"
    end
  end

end


end
