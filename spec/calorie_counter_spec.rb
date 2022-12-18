# Start time: 1700
# End time: 1741
class CalorieCounter
	def self.transform(filename)
		contents = File.read(filename)

		split_contents = contents.split("\n")

		
		result = []
		collection = []
		split_contents.each do |c|
			if c == ""
				result << collection
				collection = []
			else
				collection << c.to_i
			end
		end
		result << collection

		result
	end

	def self.top_elf(filename)
		data = self.transform(filename)

		totals = data.map do |group|
			group.sum
		end

		totals.max
	end

	def self.top_three_elves(filename)
		data = self.transform(filename)

		totals = data.map do |group|
			group.sum
		end

		totals.sort.last(3).sum		
	end
end




RSpec.describe 'CalorieCounter' do
	it 'returns a 2d array' do
		filename = './fixtures/calories_dummy.txt'

		expected_result = [
			[1_000, 2_000, 3_000], [4_000], [5_000, 6_000], [7_000, 8_000, 9_000], [10_000]
		]
		expect(CalorieCounter.transform(filename)).to eq expected_result
	end

	it 'returns the result' do
		filename = './fixtures/calories_dummy.txt'

		expect(CalorieCounter.top_elf(filename)).to eq 24_000
	end

	it 'returns the top three elves total' do
		filename = './fixtures/calories_dummy.txt'

		expect(CalorieCounter.top_three_elves(filename)).to eq 45_000
	end
end


puts CalorieCounter.top_elf('./fixtures/calories.txt')
puts CalorieCounter.top_three_elves('./fixtures/calories.txt')
