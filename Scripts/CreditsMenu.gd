extends Control

func _on_Back_pressed():
	get_parent().add_main_menu()
	queue_free()
