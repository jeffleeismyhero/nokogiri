#!/usr/bin/env ruby

require 'test/unit'
require "nokogiri"

class TestBuilder < Test::Unit::TestCase
  ####
  # Modified
  def test_escaping_text
    doc = Nokogiri.Hpricot() { b "<a\"b>" }
    assert_equal "<b>&lt;a\"b&gt;</b>", doc.to_html.chomp
    assert_equal %{<a"b>}, doc.at("text()").to_s
  end

  ####
  # Modified
  def test_no_escaping_text
    doc = Nokogiri.Hpricot() { div.test.me! { text "<a\"b>" } }
    assert_equal %{<div class="test" id="me">&lt;a"b&gt;</div>},
      doc.to_html.chomp
    assert_equal %{<a"b>}, doc.at("text()").to_s
  end

  ####
  # Modified
  def test_latin1_entities
    doc = Nokogiri.Hpricot() { b "\200\225" }
    assert_equal "<b>&#21;</b>", doc.to_html.chomp
    assert_equal "\342\202\254\342\200\242", doc.at("text()").to_s
  end
end