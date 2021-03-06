module StaticsHelper
  def calculate_calories(person, day)
    calories = 0
    multiplier = 0
    weight = person['weight'].to_i / 2.2
    case day
      when 'Rest Day'
        multiplier = 1.33
      when 'Light Day'
        multiplier = 1.7
      when 'Moderate Day'
        multiplier = 2.3
      when 'Heavy Day'
        multiplier = 3.2
    end
    
    if person['gender'] == 'Man'
      case
        when person['age'].to_i <= 17
          calories = ((17.5 * weight) + 651) * multiplier
        when person['age'].to_i >= 18 && person['age'].to_i <= 29
          calories = ((15.3 * weight) + 496) * multiplier
        when person['age'].to_i >= 30
          calories = ((11.6 * weight) + 879) * multiplier
      end
    else #if person is a woman
      case
        when person['age'].to_i <= 17
          calories = ((12.2 * weight) + 746) * multiplier
        when person['age'].to_i >= 18 && person['age'].to_i <= 29
          calories = ((14.7 * weight) + 679) * multiplier
        when person['age'].to_i >= 30
          calories = ((8.7 * weight) + 829) * multiplier
      end
    end
    return calories.to_i
  end
end
