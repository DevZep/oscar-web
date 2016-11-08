describe 'Changelog' do
  let!(:admin){ create(:user, roles: 'admin') }
  let!(:changelog){ create(:changelog) }

  before do
    login_as(admin)
  end

  feature 'List' do
    before do
      FactoryGirl.create_list(:changelog, 20)
      visit changelogs_path
    end

    scenario 'change_version' do
      visit "#{changelogs_path}&page=2"
      expect(page).to have_content(changelog.change_version)
    end

    scenario 'edit link' do
      expect(page).to have_link(nil, edit_changelog_path(changelog))
    end

    scenario 'delete link' do
      visit "#{changelogs_path}&page=2"
      expect(page).to have_css("a[href='#{changelog_path(changelog)}'][data-method='delete']")
    end

    scenario 'show link' do
      expect(page).to have_link(nil, changelog_path(changelog))
    end

    scenario 'new link' do
      expect(page).to have_link(I18n.t('changelogs.index.add_new_changelog'), new_changelog_path)
    end
  end

  feature 'Create', js: true do
    before do
      visit changelogs_path
    end

    scenario 'valid' do
      click_link('Add New Changelog')
      within('#new_changelog') do
        fill_in 'changelog_change_version', with: FFaker::Name.name
        click_link('Add change')
        fill_in 'Description', with: FFaker::Lorem.paragraph
        click_button I18n.t('changelogs.form.save')
      end
      expect(page).to have_content(I18n.t('changelogs.create.successfully_created'))
    end

    scenario 'invalid' do
      click_link('Add New Changelog')
      within('#new_changelog') do
        click_button I18n.t('changelogs.form.save')
      end
      expect(page).to have_content('Failed to create a changelog.')
    end
  end

  feature 'Edit', js: true do
    let!(:change_version) { FFaker::Name.name }
    let!(:other_changelog) { create(:changelog, change_version: '0.1') }

    before do
      visit changelogs_path(changelog)
    end
    scenario 'valid' do
      find("a[data-target='#changelogModal-#{changelog.id}']").click
      within("#changelogModal-#{changelog.id}") do
        fill_in 'changelog_change_version', with: change_version
        click_button I18n.t('changelogs.form.save')
      end
      expect(page).to have_content(I18n.t('changelogs.update.successfully_updated'))
      expect(page).to have_content(change_version)
    end
    scenario 'invalid' do
      find("a[data-target='#changelogModal-#{changelog.id}']").click
      within("#changelogModal-#{changelog.id}") do
        fill_in 'changelog_change_version', with: '0.1'
        click_button I18n.t('changelogs.form.save')
      end
      expect(page).to have_content('Failed to update a changelog.')
    end
  end

  feature 'Delete', js: true do
    before do
      visit changelogs_path
    end
    scenario 'success' do
      find("a[href='#{changelog_path(changelog)}'][data-method='delete']").click
      expect(page).to have_content(I18n.t('changelogs.destroy.successfully_deleted'))
    end
  end

  feature 'Show' do
    before do
      visit changelog_path(changelog)
    end
    scenario 'success' do
      expect(page).to have_content(changelog.change_version)
    end
    scenario 'link back to index' do
      expect(page).to have_link(nil, changelogs_path)
    end
  end
end
