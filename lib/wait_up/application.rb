require 'gir_ffi-gtk3'

module WaitUp
  # Main Wait Up application class
  class Application
    def initialize
      setup_gui
      connect_signals
      @win.show_all
    end

    private

    def connect_signals
      connect_key_press_event_signal
      connect_destroy_signal
      connect_slide_signal
      connect_file_chooser_signal
    end

    def connect_destroy_signal
      @win.signal_connect('destroy') { Gtk.main_quit }
    end

    def connect_key_press_event_signal
      @win.signal_connect 'key-press-event' do |_wdg, evt, _ud|
        handle_key(evt) if evt.state == :control_mask
        false
      end
    end

    def handle_key(evt)
      case evt.keyval
      when 'q'.ord
        @win.destroy
      end
    end

    def connect_slide_signal
      @timeline.signal_connect 'format-value' do |_scale, value, _user_data|
        ">#{value}<"
      end
    end

    def connect_file_chooser_signal
      @chooser.signal_connect 'file-set' do |_widget, _user_data|
        puts @chooser.filename
      end
    end

    def setup_gui
      @win = Gtk::Window.new :toplevel
      @grid = Gtk::Grid.new
      @grid.orientation = :vertical
      @win.add @grid
      @chooser = Gtk::FileChooserButton.new('Hello!', :open)
      @grid.add @chooser
      @timeline = Gtk::Scale.new_with_range :horizontal, 0.0, 10.0, 0.1
      @timeline.hexpand = true
      @grid.add @timeline
      @volume = Gtk::VolumeButton.new
      @grid.add @volume
    end
  end
end
