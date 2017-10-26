module QuestionsHelper

  def lock_image(question)
    question.answered ? 'unlock.png' :'lock.png'
  end
end
