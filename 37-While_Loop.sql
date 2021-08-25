-- While Dongusu

-- While sart komut

Declare @sayac int = 0

while @sayac < 10
	Begin
		print @sayac
		Set @sayac += 1
	End


-- Break

Declare @sayac int = 0

while @sayac < 10
	Begin
		print @sayac
		Set @sayac += 1
		If @sayac % 5 = 0
			Break
	End


-- Continue

Declare @sayac int = 0

while @sayac < 20
	Begin
		If @sayac % 5 = 0
			Begin
				Set @sayac += 1	
				Continue
			End
		print @sayac
		Set @sayac += 1
	End