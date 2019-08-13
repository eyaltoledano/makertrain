module VersionsHelper

  def progress_bar(version)
    # builds a progress bar for the version
    # content_tag :div, class: 'progress' do
    #   content_tag :div, class: ['progress-bar', 'bg-info'], html: {role: 'progress-bar', style: "width: 20%", aria-valuenow: '20', arie-value-min: '0', aria-valuemax: '100'}
    # end
    # <div class="progress">
    #   <div class="progress-bar bg-info" role="progressbar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
    # </div>
  end
end
