require 'test_helper'

class AccountTest < Minitest::Test
  def test_url
    assert_equal "accounts", Tito::Account.all_path
  end

  def test_listing_accounts
    stub_accounts
    accounts = Tito::Account.all
    assert_equal 'paulca', accounts.first.slug
    assert_equal 'Paul Campbell', accounts.first.name
  end
end