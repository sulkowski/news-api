class NewsApi
  def call(_env)
    [200, { 'Content-Type' => 'text/plain' }, []]
  end
end
