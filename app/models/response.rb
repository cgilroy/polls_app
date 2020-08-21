class Response < ApplicationRecord
    belongs_to :answer_choice,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class: 'AnswerChoice'
    
    belongs_to :respondent,
        primary_key: :id,
        foreign_key: :respondent_id,
        class: 'User'
    
end