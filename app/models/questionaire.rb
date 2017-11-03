class Questionaire < ApplicationRecord

  #============== Associations =================
  belongs_to :team, inverse_of: :questionaire
  has_many :questions, inverse_of: :questionaire, dependent: :destroy

  #============== Validations ==================
  validates :team, presence: true

  #============== Nested attributes ============
  accepts_nested_attributes_for :questions

  #============= Callbacks =====================
  after_create :populate_questions

  private
  def populate_questions
    case name
      # Red
      when 'red'
        questions.create(statement: "What's Mappening?", description: 'Match letters to question numbers. Translate "FACE" to numbers.', answer: '8369', hint: 'What numbers spell face?', category: '4 Number')
        questions.create(statement: 'Africa in Pieces', description: 'Which countries have the given independence days. Letters spell the answer. Uganda (W), Egypt (O), Chad (R), Botswana (L), Morocco (D)', answer: 'WORLD', hint: 'Which countries have these independence dates?', category: 'Word', options: ['WORLD', 'EGYPT', 'UGANDA', 'OZARK'])
        questions.create(statement: 'Driftin Away', description: 'Answer questions and circle each of these letters L=left, R=right, U=up,D=down. continents, pangaea, continentaL DRift, afRica, aRctic, Rock', answer: 'LDRRRR', hint: 'R=right, U=up, L=left, D=down. Which of these are found in the answers?', category: 'Directional')
        questions.create(statement: 'Divided they Fall', description: '"Three are better than none, some are greater than one" Question numbers of answers greater than one are solution. 1, 6, 8', answer: '168', hint: 'Which number questions have an answer greater than 1?', category: '3 Number')

      #Green
      when 'green'
        questions.create(statement: 'Speech Teach', description: 'Put Gettysburg Address in order.Numbers spell code.', answer: '2724', hint: 'Google the first line to find which speech.Put in order to find number code.', category: '4 Number')
        questions.create(statement: 'Fishing', description: 'Answer questions to get five letters.', answer: 'TITLE', hint: "Fishing doesn't impress anyone.", category: 'Word', options: ['TITLE', 'SAMPLE', 'TIRED', 'WORLD'])
        questions.create(statement: 'US Crossword', description: "Solve terms with a 'dot' in them. SUTTER 23D,EXECUTIVE 17R, SEGREGATION 9D, CARTER 31R ARMSTRONG 3D", answer: 'DRDRD', hint: 'Which term have a dot in them?', category: 'Directional')
        questions.create(statement: 'Landformula', description: 'Answer questions. Questions where the second word is correct give the digits.', answer: '145', hint: "Which question's answers are the second word?", category: '3 Number')

      #Yellow
      when 'yellow'
        questions.create(statement: 'Synonimble', description: 'Match synonyms. Count vowels in original word an synonym. Use question numbers where original word has less vowels than synonym. 3-Happy, 4-Brilliant, 12-Mistake', answer: '3412', hint: '"Happy" has 2 vowels, while "glad" only has 1 vowel', category: '4 Number')
        questions.create(statement: 'Subtraction Action', description: 'Do all problems. Add all answers. Convert to letters using cipher. 79480', answer: 'SPORE', hint: 'Add all answers together. Convert to a word using given system.', category: 'Word', options: ['TITLE', 'WORLD', 'SPORE', 'FRESH'])
        questions.create(statement: 'Brain Rain', description: 'Passage hints at spots. Hot Season=Summer, Gold=Rainbow, Twister=Tornado, Bolt=Lightning, Blow=Wind, Precipitate=Rain, Bright=Sun', answer: 'DDLULU', hint: 'Start at Summer and take 6 steps', category: 'Directional')
        questions.create(statement: 'Egyptian Math', description: 'Translate the symbols into numbers. Add and subtract to get final answer.', answer: '811', hint: 'The first glyph is 527', category: '3 Number')

      #pink
      when 'pink'
        questions.create(statement: 'Fractured Decimals', description: "I’ve got “two” tell you that you’re the “tenths” person to visit this “place.”' Question numbers with 2 in the tenths place spell the answer. 1, 5, 15", answer: '1515', hint: 'Which questions have 2 in the tenths place?', category: '4 Number')
        questions.create(statement: 'Epic Center', description: 'Find difference of P and S waves.Use graph to find distance, which leads to 5 letters.', answer: 'FRESH', hint: 'Find the difference of P and S waves. Use graph to find distance.', category: 'Word', options: ['WORLD', 'FRESH', 'TIRED', 'DRAINED'])
        questions.create(statement: 'Greatness', description: 'Solve problems. Starting at top left underlined answer, move in the direction of the highest number available 6 times.', answer: 'DDRRUU', hint: 'Go in the direction of the largest number next to you. Do this six times.', category: 'Directional')
        questions.create(statement: 'Miss Spelling', description: 'Find misspelled words. Add those question numbers. 3, 4, 7, 12, 15, 16, 20, 25, 29, 32, 38, 40, 45', answer: '286', hint: 'Add the question numbers of all misspelled words.', category: '3 Number')

      #blue
      when 'blue'
        questions.create(statement: 'Be Productive', description: 'Which answers have a 7 in them? The question numbers with a 7 in the answer spell the code.', answer: '2810', hint: 'Three problems have a 7 in their answer.', category: '4 Number')
        questions.create(statement: 'Mappetite', description: 'Denver, Des Moines, Tallahassee, Columbus, Pierre. Find which states these are capitals. Letters in map spell code. Colorado=O, Iowa=Z, Florida=A, Ohio=R, South Dakota=K', answer: 'OZARK', hint: 'Which states have these capitals?', category: 'Word', options: ['NEWYORK', 'OZARK', 'FLORIDA', 'FINLAND'])
        questions.create(statement: "Moh's Scale", description: "Follow Moh's hardness scale. From START, go in the direction of minerals from the scale: 1-10. Talc, Gypsum, Calcite, Fluorite, Apatite, Orthoclase, Quartz, Topaz, Corundum, Diamond", answer: 'RULURRDRUU', hint: "Google Moh's Hardness Scale. Go towards 1, 2, 3 up to 10", category: 'Directional')
        questions.create(statement: 'Agree Mint', description: 'This should only take a second. The question numbers where the second choice is correct spell the code. 1, 3, 8', answer: '138', hint: 'Either / or agrees with the subject written last closest to the verb.', category: '3 Number')

      #purple
      when 'purple'
        questions.create(statement: 'Exploration', description: 'No CAGE could hold these explorers.Which numbers match the CAGE? C=4,A=2,G=3,E=5', answer: '4235', hint: 'Which numbers spell CAGE?', category: '4 Number')
        questions.create(statement: 'Earthwords', description: 'The first letter of the answers for 38456. The first letter of the answer for question 3, 8, 4, 5, 6 in order.', answer: 'TIRED', hint: 'Lithosphere contains up parts of two layers.', category: 'Word', options: ['FRESH', 'DRAINED', 'TIRED', 'EXHAUSTED'])
        questions.create(statement: 'Division Hero', description: 'Start remainder 0,end remainder 8.Begin at the answer with R=0 more towards R=1,R=2...R=8', answer: 'RULULDLD', hint: '5 into 20 has remainder 0, so start there,Move 8 times.', category: 'Directional')
        questions.create(statement: 'Capital Idea', description: 'FOUR this puzzle, count the capital letters. Find which question numbers need exactly 4 capital letters.', answer: '259', hint: 'Which questions need 4 capital letters?', category: '3 Number')
      else
    end
  end

end
