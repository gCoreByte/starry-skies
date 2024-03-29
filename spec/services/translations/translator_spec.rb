# frozen_string_literal: true

RSpec.describe Translations::Translator do
  let!(:locale) { :en }
  let!(:record) { create(:product) }

  subject { described_class.new(record: record, locale: locale) }

  describe '#translate' do
    context 'when record is not translatable' do
      let!(:record) { create(:page) }

      it do
        expect(subject).to validate_errors_on(:base).with_details(error: :untranslatable)
      end
    end

    context 'when record is translatable' do
      context 'when locale is not valid' do
        let!(:locale) { 'aetadsfas' }

        it do
          expect(subject).to validate_errors_on(:base).with_details(error: :unsupported_locale)
        end
      end

      context 'when locale is string' do
        let!(:locale) { 'en' }

        it do
          expect(subject.translate('name')).to eq('translated english')
        end
      end

      context 'when locale is symbol' do
        let!(:locale) { :en }

        it do
          expect(subject.translate('name')).to eq('translated english')
        end
      end

      context 'when translation is symbol' do
        it do
          expect(subject.translate(:name)).to eq('translated english')
        end
      end

      context 'when translation is not found' do
        let!(:record) { create(:product, translations: {}) }

        it do
          expect(subject.translate(:name)).to be_nil
        end
      end

      context 'when translation is not a valid key' do
        it do
          expect(subject.translate(:invalid_key)).to be_nil
        end
      end
    end
  end
end
