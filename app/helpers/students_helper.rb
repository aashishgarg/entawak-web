module StudentsHelper

  def options_for_number_question
    options = []
    (0..9).each {|option| options<< [option, option]}
    options
  end

  def options_for_word_question
    options =[]
    ("a".."z").each {|option| options<< [option, option]}
  end

  def options_for_direction_questions
    [['L', 'L'], ['U', 'U'], ['R', 'R'], ['D', 'D']]
  end


end
