class AnswerChoice
    validates :text, presence: true

    belongs_to :question
        primary_key: :id,
        foreign_key: :question_id,
        class: 'Question'

    has_many :responses
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class: 'Response'
end