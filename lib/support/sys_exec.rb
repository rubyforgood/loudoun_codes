require 'open3'

module Support
  module SysExec
    def err; @err end
    def out; @out end
    def sys_exec(cmd)
      Open3.popen3(cmd.to_s) do |stdin, stdout, stderr, wait_thr|
        yield stdin, stdout, wait_thr if block_given?
        stdin.close

        @exitstatus = wait_thr && wait_thr.value.exitstatus
        @out = Thread.new { stdout.read }.value.strip
        @err = Thread.new { stderr.read }.value.strip
      end

      (@all_output ||= String.new) << [
        "$ #{cmd.to_s.strip}",
        out,
        err,
        @exitstatus ? "# $? => #{@exitstatus}" : "",
        "\n",
      ].reject(&:empty?).join("\n")

      @out
    end
  end
end
